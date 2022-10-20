// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//This contract contains a method that transfers Ether and it can be publically accessed.
contract UnprotectedEtherTransfer {
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
        employees[msg.sender]=0;
        payable(msg.sender).transfer(employees[msg.sender]);
    }

    function cancelContract() external onlyOwner {
        selfdestruct(payable(msg.sender));
    }
}