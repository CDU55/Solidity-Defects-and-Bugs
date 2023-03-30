// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract contains a tautology in its "require", an unsigned integer will always be lower than the maximum value that the bit length can hold
contract AssertAlwaysTrue {
    uint256 public maxUintValue = 2**256 - 1;

    function uselessAssertUint(uint256 parameter)
        external
        view
        returns (uint256)
    {
        require(parameter < maxUintValue);
        return parameter;
    }
}
