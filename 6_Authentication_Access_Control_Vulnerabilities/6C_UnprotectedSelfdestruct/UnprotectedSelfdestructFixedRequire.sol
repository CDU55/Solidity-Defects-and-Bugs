// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Check the msg.sender value via a "require" statement
contract UnprotectedSelfdestructFixedRequire {
    
    mapping(address => uint) private _employees;
    address private _owner;

    constructor()
    {
        _owner=msg.sender;
    }

    function sendSalary(address employeeAddress) payable external{
        require(msg.sender==_owner,"Only the owner of the contract can access this method");
        _employees[employeeAddress]=msg.value;
    }

    function getSalary() external{
        require(_employees[msg.sender]>0,"You cannot receive your salary at this moment");
        _employees[msg.sender]=0;
        payable(msg.sender).transfer(_employees[msg.sender]);
    }

    function cancelContract() external {
        require(msg.sender==_owner,"Only the owner of the contract can access this method");
        selfdestruct(payable(msg.sender));
    }
}