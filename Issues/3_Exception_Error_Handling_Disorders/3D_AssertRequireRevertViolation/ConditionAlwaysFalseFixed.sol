// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract ConditionAlwaysFalse {
    function notGonnaExecute(uint256 parameter)
        external
        pure
        returns (uint256)
    {
        require(parameter <= 0); // this condition can be true, so no failure
        return parameter;
    }
}
