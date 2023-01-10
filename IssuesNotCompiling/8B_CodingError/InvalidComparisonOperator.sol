// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//The operator "=" is used instead of "==", this typo could cause unexpected results
contract InvalidComparisonOperator{
    function compare(uint a, uint b) public returns (bool){
        if(a=b)
        {
            return true;
        }
        return false;
    }
}