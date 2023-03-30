// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

// Fix: assert a different condition
contract ConditionAlwaysFalse {
    function notGonnaExecute(uint256 parameter1, uint256 parameter2)
        external
        pure
        returns (uint256)
    {
        uint256 number = parameter1 * parameter2;
        assert(number != 0);
        return number;
    }
}
