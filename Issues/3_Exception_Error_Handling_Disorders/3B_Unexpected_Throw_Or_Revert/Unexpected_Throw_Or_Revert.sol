// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Once a higher bid is submitted, the previous bid is returned to the corresponding bidder.
//However, if the previous bidder is a contract with a complex callback, the "send" operation will never succed. Thus, that bid will never be replaced.
contract UnexpectedThrowOrRevert {
    address private _highestBidder;
    uint256 private _highestBid;

    function bid() external payable {
        if (msg.value > _highestBid) {
            require(payable(_highestBidder).send(_highestBid));
            _highestBidder = msg.sender;
            _highestBid = msg.value;
        } else {
            revert("The big was lower than the current highest bid");
        }
    }
}
