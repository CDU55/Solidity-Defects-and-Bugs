// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//This contract contains a tautology in its "require", an unsigned integer will always be lower than the maximum value that the bit length can hold
contract AssertAlwaysTrue{
    
    uint public maxUintValue=2**256-1;
    
    function uselessAssertUint(uint parameter) external view returns(uint)
    {
        require(parameter<maxUintValue);
        return parameter;
    }
}