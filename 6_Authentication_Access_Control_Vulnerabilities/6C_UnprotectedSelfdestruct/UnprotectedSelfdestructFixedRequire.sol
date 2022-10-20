// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Fix: Check the msg.sender value via a "require" statement
contract UnprotectedSelfdestructFixedRequire {
    mapping(address => uint) private employees;

    address private owner;

    constructor()
    {
        owner=msg.sender;
    }

    function sendSalary(address employeeAddress) payable external{
        require(msg.sender==owner,'Only the owner of the contract can access this method');
        employees[employeeAddress]=msg.value;
    }

    function getSalary() external{
        require(employees[msg.sender]>0,'You cannot receive your salary at this moment');
        employees[msg.sender]=0;
        payable(msg.sender).transfer(employees[msg.sender]);
    }

    function cancelContract() external {
        require(msg.sender==owner,'Only the owner of the contract can access this method');
        selfdestruct(payable(msg.sender));
    }
}