// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract contains a divison by an outside parameter that is not zero checked.
contract DivideByZeroMinimal {

    function divide(uint number,uint divisor) external pure returns(uint) {
        return number/divisor;
    }
}