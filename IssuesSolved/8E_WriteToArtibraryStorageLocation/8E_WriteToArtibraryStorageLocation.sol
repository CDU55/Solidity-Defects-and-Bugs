// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract WriteToArtibraryStorageLocation{

   uint public publicInfo;
   uint[] private _referenceValues;

    constructor()
    {
        _referenceValues=new uint[](0);
    }

    function addValue(uint value) external{
        _referenceValues.push(value);
    }

    function updateValue(uint index, uint value) external{
        _referenceValues[index]=value;
    }
   
}