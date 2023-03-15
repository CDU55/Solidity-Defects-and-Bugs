// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//The "onlyOwner" modifier uses a variable that is not initialized to test the ownership of the contract.
contract UnInitializedConditionStateVariable {
    mapping(address => uint256) private _employees;

    address private owner;

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only the owner of the contract can access this"
        );
        _;
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

    function cancelContract() external onlyOwner {
        selfdestruct(payable(msg.sender));
    }
}
