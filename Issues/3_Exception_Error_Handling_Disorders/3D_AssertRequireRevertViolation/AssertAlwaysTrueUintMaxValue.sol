// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

// Tautology in require: an uint will always be less or equal than uint.max
contract AssertAlwaysTrue {
    uint256 public maxUintValue = type(uint256).max;

    function uselessAssertUint(uint256 parameter)
        external
        view
        returns (uint256)
    {
        require(parameter <= maxUintValue);
        return parameter;
    }
}
