// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: remove the redundant assignment
contract DeadCodeUselessAssignmentFixed {

    uint constant interestRate = 10;
    function calculateTotalInterest(uint amount) external pure returns (uint)  {
        uint total=amount/100*interestRate;
        return total;
    }
}