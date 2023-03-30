// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract contains a tautology in its "require", an unsigned integer will always have a value higher than 0
contract ConditionAlwaysTrue {
    function uselessConditionUint(uint256 parameter)
        external
        pure
        returns (uint256)
    {
        require(parameter > 0);
        return parameter;
    }
}
