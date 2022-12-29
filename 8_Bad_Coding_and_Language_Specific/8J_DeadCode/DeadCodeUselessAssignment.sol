// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract DeadCodeUselessAssignment {

    uint constant interestRate = 10;
    function calculateTotalInterest(uint amount) external pure returns (uint)  {
        uint total;
        total=amount/100*interestRate;
        total=amount/100*interestRate;
        return total;
    }
}