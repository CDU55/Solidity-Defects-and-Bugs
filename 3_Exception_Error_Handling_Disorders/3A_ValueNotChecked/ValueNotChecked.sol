// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//The value returned by the "send" instruction from the "withdraw" method is not checked.
contract ValueNotChecked {
    mapping(address => uint) private balance;
    bool internal lockedWithdraw;

    function deposit(uint amount) external payable {
        require(msg.value == amount, 'incorrect amount');
        balance[msg.sender] = amount;
    }

    //Obs: slither reentracy false positive
     function withdraw() external {
        require(balance[msg.sender]!=0,'No balance found');
        require(!lockedWithdraw,'A withdraw operation is already in progress, please wait');
        lockedWithdraw=true;
        uint toSend=balance[msg.sender];
        payable(msg.sender).send(toSend);
        balance[msg.sender]=0;
        lockedWithdraw=false;
    }
}