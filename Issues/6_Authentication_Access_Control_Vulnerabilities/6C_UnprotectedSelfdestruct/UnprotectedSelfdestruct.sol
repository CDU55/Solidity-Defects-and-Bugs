// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//The suicide mechanism of this contract is publically accessible
contract UnprotectedSelfdestruct {
    mapping(address => uint256) private _employees;
    address private _owner;

    modifier onlyOwner() {
        require(
            msg.sender == _owner,
            "Only the owner of the contract can access this"
        );
        _;
    }

    constructor() {
        _owner = msg.sender;
    }

    function sendSalary(address employeeAddress) external payable onlyOwner {
        _employees[employeeAddress] = msg.value;
    }

    function getSalary() external {
        require(
            _employees[msg.sender] > 0,
            "You cannot receive your salary at this moment"
        );
        _employees[msg.sender] = 0;
        payable(msg.sender).transfer(_employees[msg.sender]);
    }

    function cancelContract() external {
        selfdestruct(payable(msg.sender));
    }
}
