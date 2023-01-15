// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Check the value of msg.send using an access modifier
contract UnprotectedEtherTransferFixedModifier {
    
    mapping(address => uint) private _employees;
    address private _owner;

      modifier onlyOwner() {
        require(msg.sender == _owner, "Only the owner of the contract can access this");
        _;
    }

     modifier employee() {
        require(_employees[msg.sender]>0,"You cannot receive your salary at this moment");
        _;
    }

      constructor()
    {
        _owner=msg.sender;
    }

    function sendSalary(address employeeAddress) payable external onlyOwner{
        _employees[employeeAddress]=msg.value;
    }

    function getSalary() employee external{
        _employees[msg.sender]=0;
        payable(msg.sender).transfer(_employees[msg.sender]);
    }

    function cancelContract() external onlyOwner {
        selfdestruct(payable(msg.sender));
    }
}