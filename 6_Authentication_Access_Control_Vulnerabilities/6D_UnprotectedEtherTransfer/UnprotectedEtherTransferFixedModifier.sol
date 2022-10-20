// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Fix: Check the value of msg.send using an access modifier
contract UnprotectedEtherTransferFixedModifier {
    mapping(address => uint) private employees;

    address private owner;

      modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner of the contract can access this");
        _;
    }

     modifier employee() {
        require(employees[msg.sender]>0,'You cannot receive your salary at this moment');
        _;
    }

      constructor()
    {
        owner=msg.sender;
    }

    function sendSalary(address employeeAddress) payable external onlyOwner{
        employees[employeeAddress]=msg.value;
    }

    function getSalary() employee external{
        employees[msg.sender]=0;
        payable(msg.sender).transfer(employees[msg.sender]);
    }

    function cancelContract() external onlyOwner {
        selfdestruct(payable(msg.sender));
    }
}