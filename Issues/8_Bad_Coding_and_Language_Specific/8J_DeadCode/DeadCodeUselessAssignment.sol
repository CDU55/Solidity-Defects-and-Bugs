// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//The variable "total" is assigned twice.
contract DeadCodeUselessAssignment {
    uint256 constant interestRate = 10;

    function calculateTotalInterest(uint256 amount)
        external
        pure
        returns (uint256)
    {
        uint256 total;
        total = (amount / 100) * interestRate;
        total = (amount / 100) * interestRate;
        return total;
    }
}
