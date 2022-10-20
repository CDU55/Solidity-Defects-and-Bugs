// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//This contract contains a "DAO-like" reentrancy vulnerability
contract ReentrancyDAO {
    mapping(address => uint) private balance;

    function deposit() external payable {
        balance[msg.sender] = msg.value;
    }

     function withdraw() external {
        require(balance[msg.sender]!=0,'No balance found');
        uint toSend=balance[msg.sender];
        payable(msg.sender).call{value: toSend}("");
        balance[msg.sender]=0;
    }
}