// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//This contract contains a tautology in its "require", an unsigned integer will always have a value higher than 0
contract AssertAlwaysTrue{
    
    function uselessAssertUint(uint parameter) external pure returns(uint)
    {
        require(parameter>=0);
        return parameter;
    }
}