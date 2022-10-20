// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Fix: Use a lock mechanism to prevent reentrancy
//Using the lock pattern to try and trick the analysis tools
contract ReentrancyDAOFixedLock {
    mapping(address => uint) private balance;
    bool internal lockedWithdraw;

 function deposit() external payable {
        balance[msg.sender] = msg.value;
    }

    //Obs: slither reentracy false positive
     function withdraw() external {
        require(balance[msg.sender]!=0,'No balance found');
        require(!lockedWithdraw,'A withdraw operation is already in progress, please wait');
        lockedWithdraw=true;
        uint toSend=balance[msg.sender];
        (bool sent,) = payable(msg.sender).call{value: toSend}("");
        require(sent, "Failed to send Ether");
        balance[msg.sender]=0;
        lockedWithdraw=false;
    }
}