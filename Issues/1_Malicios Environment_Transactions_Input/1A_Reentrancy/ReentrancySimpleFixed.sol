// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract ReentrancySimpleFixed {
    mapping(address => uint) private balance;

    function deposit() external payable {
        balance[msg.sender] = msg.value;
    }

    function withdraw() external {
        uint addrBal = balance[msg.sender];
        balance[msg.sender] = 0;
        (bool success,) = payable(msg.sender).call{value: addrBal}("");
        require(success);
    }
}