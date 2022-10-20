// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13;

//Fix: Use a dedicated function that calculates the sum in a safe manner
contract IntegerOverflowAddFixed {
    address private owner;
    mapping (uint=>Expense) private expenses;
    uint private _expensesCount;

    struct Expense{
        uint Value;
        string Description;
    }

    function add(uint a, uint b) internal pure returns (uint) {
        uint maxInt = 2**256 - 1;
        require(a + b < maxInt,'Integer Overflow on operation');
        return a + b;
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
            totalExpense=add(totalExpense,expenses[index].Value);
        }
        return totalExpense;
    }
    
    constructor()
    {
        owner=msg.sender;
    }
}