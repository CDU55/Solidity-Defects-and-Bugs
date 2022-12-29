// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ShortAddress {
    mapping(address => uint) private balance;

    function deposit() external payable {
        balance[msg.sender] = msg.value;
    }

     function withdraw() external {
        require(balance[msg.sender]!=0,'No balance found');
        uint toSend=balance[msg.sender];
        payable(msg.sender).transfer(toSend);
        balance[msg.sender]=0;
    }

    function transfer(address to, uint256 value) external {
        require(balance[msg.sender]>=value,'Your balance is smaller than the transfer value');
        payable(to).transfer(value);
    }   
}