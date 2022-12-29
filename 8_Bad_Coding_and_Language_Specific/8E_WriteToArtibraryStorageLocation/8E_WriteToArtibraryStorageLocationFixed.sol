// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract WriteToArtibraryStorageLocationFixed{

   uint public publicInfo;
   uint[] private referenceValues;

    constructor()
    {
        referenceValues=new uint[](0);
    }
    
    function addValue(uint value) external{
        referenceValues.push(value);
    }

    function updateValue(uint index, uint value) external{
        require(index<referenceValues.length,'Invalid index');
        referenceValues[index]=value;
    }
   
}