// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13;

//The "calculateTotalExpense" function could return an incorrect value due to a possible overflow of the "totalExpense" variable
contract IntegerOverflowAdd {
    address private owner;
    mapping (uint=>Expense) private expenses;
    uint private _expensesCount;

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
            totalExpense+=expenses[index].Value;
        }
        return totalExpense;
    }

    constructor()
    {
        owner=msg.sender;
    }
}