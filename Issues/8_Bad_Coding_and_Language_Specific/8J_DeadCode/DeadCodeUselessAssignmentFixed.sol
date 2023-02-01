// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: remove the redundant assignment
contract DeadCodeUselessAssignmentFixed {
    uint256 constant interestRate = 10;

    function calculateTotalInterest(uint256 amount)
        external
        pure
        returns (uint256)
    {
        uint256 total = (amount / 100) * interestRate;
        return total;
    }
}
