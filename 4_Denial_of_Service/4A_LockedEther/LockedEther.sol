// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//This contract has a payble function, thus can receive Ether. However, it does not define a function to transfer the Ether.
contract LockedEther {
    mapping(address => uint) private balance;

    function deposit(uint amount) external payable {
        require(msg.value == amount, 'incorrect amount');
        balance[msg.sender] = amount;
    }
}
