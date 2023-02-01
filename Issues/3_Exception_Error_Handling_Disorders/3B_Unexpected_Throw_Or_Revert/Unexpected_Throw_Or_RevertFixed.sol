// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Implement a "pull" rather than "push" payment via a cashback method.
contract UnexpectedThrowOrRevertFixed {
    address private _highestBidder;
    uint256 private _highestBid;

    mapping(address => uint256) owedFormerHighestBidders;

    function Bid() external payable {
        if (msg.value > _highestBid) {
            owedFormerHighestBidders[_highestBidder] += _highestBid;
            _highestBidder = msg.sender;
            _highestBid = msg.value;
        } else {
            revert("The big was lower than the current highest bid");
        }
    }

    function Cashback() external {
        require(
            owedFormerHighestBidders[msg.sender] > 0,
            "You have nothing to collect"
        );
        payable(msg.sender).transfer(owedFormerHighestBidders[msg.sender]);
    }
}
