// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Fix: Use a dedicated function that performs the multiplication in a safe manner
contract IntegerOverflowMulFixed {

    function multiply(uint a, uint b) internal pure returns (uint) {
      if (a == 0) {
        return 0;
      }

      uint c = a * b;
      require(c / a == b,'Integer Overflow for multiplication');

      return c;
    }

    function calculateFactorial(uint number) public pure returns(uint)
    {
        uint factorial=1;
        for(uint currentNumber=2;currentNumber<=number;currentNumber++)
        {
            factorial=multiply(number, factorial);
        }
        return factorial;
    }
}