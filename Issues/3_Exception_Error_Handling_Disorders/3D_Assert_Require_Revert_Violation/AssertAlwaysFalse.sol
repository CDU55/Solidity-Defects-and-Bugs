// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract AssertAlwaysFalse{
    
    function notGonnaExecute(uint parameter) external pure returns(uint)
    {
        require(parameter<0); // this require always fails because paramenter is uint
        return parameter;
    }
}