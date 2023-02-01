// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract contains a divison by an outside parameter that is not zero checked.
contract DivideByZeroMinimal {
    function divide(uint256 number, uint256 divisor)
        external
        pure
        returns (uint256)
    {
        return number / divisor;
    }
}
