// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Provide a reson for "require".
contract ReasonStringFixed {
    mapping(address => uint256) private _balance;

    function deposit(uint256 amount) external payable {
        require(msg.value == amount, "Incorrect amount");
        _balance[msg.sender] = amount;
    }

    function withdraw() external {
        uint256 toSend = _balance[msg.sender];
        require(_balance[msg.sender] != 0, "No balance found");
        _balance[msg.sender] = 0;
        bool sent = payable(msg.sender).send(toSend);
        require(sent, "Failed to send Ether");
    }
}
