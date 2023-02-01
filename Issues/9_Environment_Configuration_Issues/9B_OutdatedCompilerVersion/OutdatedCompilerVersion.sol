// SPDX-License-Identifier: MIT
pragma solidity ^0.6.8;

//This contract does not use the latest compiler version, which can lead to unexpected results like integer overflow.
contract OutdatedCompilerVersion {
    address private owner;
    mapping(uint256 => Expense) private _expenses;
    uint256 private _expensesCount;

    struct Expense {
        uint256 Value;
        uint256 ExpsenseId;
    }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only the owner of the contract can access this"
        );
        _;
    }

    constructor() public {
        owner = msg.sender;
    }

    function registerExpense(uint256 value, uint256 expenseId)
        external
        onlyOwner
    {
        _expenses[_expensesCount] = Expense(value, expenseId);
        _expensesCount++;
    }

    function calculateTotalExpense() external view onlyOwner returns (uint256) {
        uint256 totalExpense;
        for (uint256 index = 0; index < _expensesCount; index++) {
            totalExpense += _expenses[index].Value;
        }
        return totalExpense;
    }
}
