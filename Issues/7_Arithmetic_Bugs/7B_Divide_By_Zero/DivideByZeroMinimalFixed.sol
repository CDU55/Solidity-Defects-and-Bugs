// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Check that the divisor is not zero
contract DivideByZeroMinimalFixed {
    function divide(uint256 number, uint256 divisor)
        external
        pure
        returns (uint256)
    {
        return number / divisor + 1;
    }
}
