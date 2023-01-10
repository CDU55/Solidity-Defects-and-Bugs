// SPDX-License-Identifier: MIT
pragma solidity ^0.6.8;

//This contract does not use the latest compiler version, which can lead to unexpected results like integer overflow.
contract OutdatedCompilerVersion {
    
    address private owner;
    mapping (uint=>Expense) private _expenses;
    uint private _expensesCount;

    struct Expense{
        uint Value;
        uint ExpsenseId;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner of the contract can access this");
        _;
    }

    constructor() public
    {
        owner=msg.sender;
    }

    function registerExpense(uint value,uint expenseId) external onlyOwner
    {
        _expenses[_expensesCount]=Expense(value,expenseId);
        _expensesCount++;
    }

    function calculateTotalExpense() external view onlyOwner returns (uint)
    {
        uint totalExpense;
        for(uint index=0;index<_expensesCount;index++)
        {
            totalExpense+=_expenses[index].Value;
        }
        return totalExpense;
    }
}