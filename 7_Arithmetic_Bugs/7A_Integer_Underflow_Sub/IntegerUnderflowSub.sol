// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13;

//The "payDebt" function could produce unwanted effects if the indebted pays more than what he owes due to Integer Underflow
contract IntegerUnderflowSub{

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
        indebted[msg.sender]=indebted[msg.sender]-msg.value;
    }

    function getDebt() external view returns(uint){
        require(indebted[msg.sender]!=0,'You are not indebted');
        return indebted[msg.sender];
    } 
}