// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract performs a division where the divisor is always zero.
contract DivideByZeroMinimal {
    function divide(uint256 number1, uint256 number2)
        public
        pure
        returns (uint256)
    {
        return number1 / (number2 - number2);
    }
}
