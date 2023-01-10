// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13;

contract BidderRegistry{

    uint internal count;
    mapping(uint=>Bidder) bidders;
    struct Bidder{
        uint amount;
        address bidder;
        uint itemId;
    }

    function registerBidder(uint amount,uint itemId) external
    {
        count+=1;
        bidders[count]=Bidder(amount,msg.sender,itemId);
    }
}

contract ItemRegistry{
    uint internal count;
    mapping(uint=>Item) items;
    
    struct Item{
        uint startingPrice;
        address owner;
        uint itemId;
    }

    function registerItem(uint amount,uint itemId) external
    {
        count+=1;
        items[count]=Item(amount,msg.sender,itemId);
    }
}

//Avoid inheriting multiple contracts if they have elements that could cause ambiguity
  contract Auction is BidderRegistry,ItemRegistry {

    address private owner;
      modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner of the contract can access this");
        _;
    }

      constructor()
    {
        owner=msg.sender;
    }

    function resetCount() external onlyOwner{
        count=0;
    }
}