// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface LibraryInterface
{
    function getInterestRate(uint amount,uint startLoan,uint endLoan) external view returns(uint);
    function getInterest(uint amount,uint startLoan,uint endLoan) external view returns(uint);
}

contract Bank{

    struct Debt{
        uint owed;
        uint startLoan;
        uint endLoan;
        uint interestRate;
        bool active;
    }

    mapping (address=>Debt) private debters;
    LibraryInterface private _library=LibraryInterface(0xc0afEfD50B3e4961e18197DA7596033aC9d4463a);

    constructor() payable{
    }

    function loan(uint amount,uint duration) external
    {
        require(!debters[msg.sender].active,'You are already in debt');
        uint startLoan=block.timestamp;
        uint endLoan=startLoan+duration;
        uint interestRate=_library.getInterestRate(amount, startLoan, endLoan);
        uint interest=_library.getInterest(amount, startLoan, endLoan);
        uint owed=amount + interest;
        debters[msg.sender]=Debt(owed,startLoan,endLoan,interestRate,true);
        payable(msg.sender).transfer(amount);
    }
}