// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Use the latest compiler version, or atleast the latest major version
contract OutdatedCompilerVersionFixed {
    
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

    constructor()
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