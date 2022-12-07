// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Fix: Use a dedicated function that performs the subtraction in a safe manner
contract IntegerUnderflowSubFixed{

    mapping(address=>uint) private indebted;

    constructor() payable{

    }

    receive() external payable{

    }

    function subtract(uint a, uint256 b) internal pure returns (uint) {
        require(b <= a,'Integer Underflow subtraction');
        return a - b;
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
        indebted[msg.sender]=subtract(indebted[msg.sender],msg.value);
    }

    function getDebt() external view returns(uint){
        require(indebted[msg.sender]!=0,'You are not indebted');
        return indebted[msg.sender];
    } 
}