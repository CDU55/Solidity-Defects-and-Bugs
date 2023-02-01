// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Do not use parameters with the same name as state variables.
contract ShadowingStateParameterFixed {
    uint256 constant interest = 2;
    mapping(address => uint256) private _indebted;

    constructor() payable {}

    function borrow(uint256 amount) external {
        require(amount < address(this).balance, "Request amount is too high");
        require(_indebted[msg.sender] == 0, "You are already indebted");
        _indebted[msg.sender] = amount;
        payable(msg.sender).transfer(amount);
    }

    function payDebt() external payable {
        require(
            _indebted[msg.sender] * interest == msg.value,
            "Please repay the right amount"
        );
        _indebted[msg.sender] = 0;
    }

    function getDebt() external view returns (uint256) {
        require(_indebted[msg.sender] != 0, "You are not indebted");
        return _indebted[msg.sender];
    }
}
