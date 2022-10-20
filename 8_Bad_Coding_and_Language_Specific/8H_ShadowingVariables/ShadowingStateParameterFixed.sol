// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Fix: Do not use parameters with the same name as state variables.
contract ShadowingStateParameterFixed{

    uint constant interest=2;
    mapping(address=>uint) private indebted;

    constructor() payable{

    }

    function borrow(uint amount) external{
        require(amount<address(this).balance,'Request amount is too high');
        require(indebted[msg.sender]==0,'You are already indebted');
        indebted[msg.sender]=amount;
        payable(msg.sender).transfer(amount);
    }

    function payDebt() payable external{
        require(indebted[msg.sender]*interest==msg.value,'Please repay the right amount');
        indebted[msg.sender]=0;
    }

     function getDebt() external view returns(uint){
        require(indebted[msg.sender]!=0,'You are not indebted');
        return indebted[msg.sender];
    }  
}