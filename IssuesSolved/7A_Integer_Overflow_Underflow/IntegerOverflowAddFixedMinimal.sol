// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Perform and overflow check before calculating the sum
contract IntegerOverflowAdd {
    address private owner;
    mapping (uint=>Expense) private expenses;
    uint private _expensesCount;
    uint constant maxInt=2**256-1;

    struct Expense{
        uint Value;
        string Description;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner of the contract can access this");
        _;
    }

    function registerExpense(Expense calldata exp) external onlyOwner
    {
        expenses[_expensesCount]=exp;
        _expensesCount++;
    }

    function calculateTotalExpense() external view onlyOwner returns (uint)
    {
        uint totalExpense;
        for(uint index=0;index<_expensesCount;index++)
        {
            require(totalExpense + expenses[index].Value < maxInt,"Integer Overflow on operation");
            totalExpense+=expenses[index].Value;
        }
        return totalExpense;
    }
    
    constructor()
    {
        owner=msg.sender;
    }
}