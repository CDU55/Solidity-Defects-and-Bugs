// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//The suicide mechanism of this contract is publically accessible
contract UnprotectedSelfdestruct {
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

    function cancelContract() external {
        selfdestruct(payable(msg.sender));
    }
}