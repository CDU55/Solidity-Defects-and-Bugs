// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Fix: Check the value returned by the send instruction
contract ValueNotCheckedFixed {
    mapping(address => uint) private balance;
    bool internal lockedWithdraw;

    function deposit(uint amount) public payable {
        require(msg.value == amount, 'incorrect amount');
        balance[msg.sender] = amount;
    }

    //Obs: slither reentracy false positive
     function withdraw() public {
        require(balance[msg.sender]!=0,'No balance found');
        require(!lockedWithdraw,'A withdraw operation is already in progress, please wait');
        lockedWithdraw=true;
        uint toSend=balance[msg.sender];
        bool sent = payable(msg.sender).send(toSend);
        require(sent, "Failed to send Ether");
        balance[msg.sender]=0;
        lockedWithdraw=false;
    }
}