// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract BidderRegistry{

    uint private bidderCount;
    mapping(uint=>Bidder) bidders;
    struct Bidder{
        uint amount;
        address bidder;
        uint itemId;
    }

    function register(uint amount,uint itemId) external
    {
        bidderCount+=1;
        bidders[bidderCount]=Bidder(amount,msg.sender,itemId);
    }
}

contract ItemRegistry{
    uint private itemsCount;
    mapping(uint=>Item) items;
    
    struct Item{
        uint startingPrice;
        address owner;
        uint itemId;
    }

    function register(uint amount,uint itemId) external
    {
        itemsCount+=1;
        items[itemsCount]=Item(amount,msg.sender,itemId);
    }
}

//The "Auction" contract inherits two contracts that have a method with the same name and the same signature
  contract Auction is BidderRegistry,ItemRegistry {

    function registerBidder(uint amount,uint itemId) external
    {
        register(amount,itemId);
    }
    
}