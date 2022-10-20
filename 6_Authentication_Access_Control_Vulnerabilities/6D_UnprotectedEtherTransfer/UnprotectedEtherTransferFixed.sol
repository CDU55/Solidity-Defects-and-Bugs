// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Fix: Check the value of msg.send in a "require" statement
contract UnprotectedEtherTransferFixed {
    mapping(address => uint) private employees;

    address private owner;

      modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner of the contract can access this");
        _;
    }

      constructor()
    {
        owner=msg.sender;
    }

    function sendSalary(address employeeAddress) payable external onlyOwner{
        employees[employeeAddress]=msg.value;
    }

    function getSalary() external{
        require(employees[msg.sender]>0,'You cannot receive your salary at this moment');
        employees[msg.sender]=0;
        payable(msg.sender).transfer(employees[msg.sender]);
    }

    function cancelContract() external onlyOwner {
        selfdestruct(payable(msg.sender));
    }
}