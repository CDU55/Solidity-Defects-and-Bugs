// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Fix: Perform and overflow check before performing the multiplication
contract IntegerOverflowMulFixedMinimal {

    function calculateFactorial(uint number) public pure returns(uint)
    {
        uint factorial=1;
        uint previousFactorial=1;
        for(uint currentNumber=2;currentNumber<=number;currentNumber++)
        {
            factorial*=currentNumber;
            require(factorial / currentNumber == previousFactorial,'Integer Overflow for multiplication');
            previousFactorial=factorial;
        }
        return factorial;
    }
}