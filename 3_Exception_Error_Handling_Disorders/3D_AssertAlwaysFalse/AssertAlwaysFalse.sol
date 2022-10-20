// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//This contract contains a contradiction in the "require" condition, unsigned integers cannot hold values below 0
contract AssertAlwaysFalse{
    
    function notGonnaExecute(uint parameter) external pure returns(uint)
    {
        require(parameter<0);
        return parameter;
    }
}