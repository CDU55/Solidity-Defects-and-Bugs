// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Fix: Define a function to transfer the Ether
contract LockedEtherFixed {
    mapping(address => uint) private balance;

    function deposit(uint amount) external payable {
        require(msg.value == amount, 'incorrect amount');
        balance[msg.sender] = amount;
    }

    //Obs: slither reentracy false positive
     function withdraw() external {
        uint toSend=balance[msg.sender];
        require(balance[msg.sender]!=0,'No balance found');
        balance[msg.sender]=0;
        bool sent = payable(msg.sender).send(toSend);
        require(sent, "Failed to send Ether");
    }
}