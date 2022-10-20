// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Fix: Use "<" instead of "<=" when iterating through the loop
contract OutOfBoundsArray {

    function getArrayMinimum(uint[] calldata array) external pure returns (uint256) {
        uint minimum=2**256-1;
        for(uint index=0;index<array.length;index++)
        {
            if(minimum>array[index])
            {
                minimum=array[index];
            }
        }
        return minimum;
    }
}