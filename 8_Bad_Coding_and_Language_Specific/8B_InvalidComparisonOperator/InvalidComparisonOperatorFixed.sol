// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13;

//Fix: Use "==" instead of "="
contract InvalidComparisonOperatorFixed{
    function compare(uint a, uint b) public pure returns (bool){
        if(a==b)
        {
            return true;
        }
        return false;
    }
}