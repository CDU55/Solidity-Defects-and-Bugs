// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Fix: Check that the divisor is not zero
contract DivideByZeroMinimalFixed {

    function divide(uint number,uint divisor) external pure returns(uint) {
        require(divisor>0,'Division by zero attempt');
        return number/divisor;
    }
}