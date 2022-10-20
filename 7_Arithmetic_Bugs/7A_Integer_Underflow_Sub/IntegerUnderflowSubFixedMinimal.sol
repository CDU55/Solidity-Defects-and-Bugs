// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13;

//Fix: Perform and underflow check before the subtraction
contract IntegerUnderflowSubFixedMinimal{

    mapping(address=>uint) private indebted;

    constructor() payable{

    }

    receive() external payable{

    }

    function borrow(uint amount) external{
        require(amount<address(this).balance,'Request amount is too high');
        require(indebted[msg.sender]==0,'You are already indebted');
        indebted[msg.sender]=amount;
        payable(msg.sender).transfer(amount);
    }

    function payDebt() payable external{
        require(msg.value>0,'Please provide attach currency to the call');
        require(indebted[msg.sender]!=0,'You are not indebted');
        require(indebted[msg.sender] <= msg.value,'Integer Underflow subtraction');
        indebted[msg.sender]=indebted[msg.sender]-msg.value;
    }

    function getDebt() external view returns(uint){
        require(indebted[msg.sender]!=0,'You are not indebted');
        return indebted[msg.sender];
    } 
}