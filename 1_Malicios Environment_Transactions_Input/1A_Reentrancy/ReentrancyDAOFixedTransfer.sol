// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Fix: Use "transfer" instead of "call" to prevent reentrancy. The imposed gas limit of the instruction will not allow a reentrancy attack.
contract ReentrancyDAOFixedTransfer {
    mapping(address => uint) private balance;

    function deposit() external payable {
        balance[msg.sender] = msg.value;
    }

    //Obs: slither reentracy false positive
     function withdraw() external {
        require(balance[msg.sender]!=0,'No balance found');
        uint toSend=balance[msg.sender];
        payable(msg.sender).transfer(toSend);
        balance[msg.sender]=0;
    }
}