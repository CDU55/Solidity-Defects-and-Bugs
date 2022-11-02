// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract UnexpectedThrowOrRevertFixed{

    address private highestBidder;
    uint private highestBid;

    mapping (address=>uint) owedFormerHighestBidders;

    function Bid() external payable
    {
        if(msg.value>highestBid)
        {
            owedFormerHighestBidders[highestBidder]+=highestBid;
            highestBidder=msg.sender;
            highestBid=msg.value;
        }
        else
        {
            revert('The big was lower than the current highest bid');
        }
    }

    function Cashback() external
    {
        require(owedFormerHighestBidders[msg.sender]>0,'You have nothing to collect');
        payable(msg.sender).transfer(owedFormerHighestBidders[msg.sender]);
    }
}