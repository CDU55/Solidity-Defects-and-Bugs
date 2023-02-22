// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract SendReturnValueNotCheckedInconsistent {
    address public highestBidder;
    uint public highestBid;
    event Bid(address, bool);

    // the previous bidder is a contract with a callback,
    // send could silently fail
    function bid() external payable {
        if (msg.value > highestBid) {
            uint hb_tmp = highestBid;
            address hd_addr = highestBidder;
            highestBid = msg.value;
            highestBidder = msg.sender;
            bool success = payable(hd_addr).send(hb_tmp);
            emit Bid(highestBidder, success);
        }
    }
}

// Scenario: 1) EOA bids x, 2) A bids y > x, 3) EOA bids z > y
// Bid ctr: 1) balance = x, 2) balance = y, 3) balance y + z!
// contract A {
//     SendReturnValueNotCheckedInconsistent private ctr;

//     constructor (address payable _ctr) {
//         ctr = SendReturnValueNotCheckedInconsistent(_ctr);
//     }

//     function bidCtr() public payable {
//         ctr.bid{value: msg.value}();
//     }

//     receive () external payable {
//         require(msg.value % 3  == 0); // sometimes fail
//     }
// }