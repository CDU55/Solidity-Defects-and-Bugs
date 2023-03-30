// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//The method will never return since there is a contradiction in the require statement, a variable cannot be different from the value that was just assigned to it.
contract AssertAlwaysFalse {
    function notGonnaExecute(uint256 parameter1, uint256 parameter2)
        external
        pure
        returns (uint256)
    {
        uint256 number = parameter1 * parameter2;
        require(number != parameter1 * parameter2);
        return number;
    }
}
