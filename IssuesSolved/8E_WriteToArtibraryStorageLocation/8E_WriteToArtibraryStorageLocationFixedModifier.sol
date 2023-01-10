// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract WriteToArtibraryStorageLocationFixed{

   uint public publicInfo;
   uint[] private referenceValues;

   address private owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner of the contract can access this");
        _;
    }

    constructor()
    {
        owner=msg.sender;
        referenceValues=new uint[](0);
    }

    function addValue(uint value) external{
        referenceValues.push(value);
    }

    function updateValue(uint index, uint value) onlyOwner external{
        referenceValues[index]=value;
    }
   
}