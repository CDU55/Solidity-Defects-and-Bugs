// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//The variable "total" is assigned twice.
contract DeadCodeUselessAssignment {

    uint constant interestRate = 10;
    function calculateTotalInterest(uint amount) external pure returns (uint)  {
        uint total;
        total=amount/100*interestRate;
        total=amount/100*interestRate;
        return total;
    }
}