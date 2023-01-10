// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//The "calculateFactorial" function could return an incorrect value due to a possible overflow of the "factorial" variable if the "number" parameter has a large value
contract IntegerOverflowMul {

    function calculateFactorial(uint number) public pure returns(uint)
    {
        uint factorial=1;
        for(uint currentNumber=2;currentNumber<=number;currentNumber++)
        {
            factorial*=currentNumber;
        }
        return factorial;
    }
}