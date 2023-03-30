// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

// No tautology in require: an uint can be less than uint.max
contract ConditionAlwaysTrue {
    uint256 public maxUintValue = type(uint256).max;

    function uselessConditionUint(uint256 parameter)
        external
        view
        returns (uint256)
    {
        require(parameter < maxUintValue);
        return parameter;
    }
}
