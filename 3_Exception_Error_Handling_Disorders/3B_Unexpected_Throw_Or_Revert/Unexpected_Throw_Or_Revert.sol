// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract UnexpectedThrowOrRevert{

    address private highestBidder;
    uint private highestBid;


    function Bid() external payable{
        if(msg.value>highestBid)
        {
            require(payable(highestBidder).send(highestBid));
            highestBidder=msg.sender;
            highestBid=msg.value;
        }
        else
        {
            revert('The big was lower than the current highest bid');
        }
    }
}