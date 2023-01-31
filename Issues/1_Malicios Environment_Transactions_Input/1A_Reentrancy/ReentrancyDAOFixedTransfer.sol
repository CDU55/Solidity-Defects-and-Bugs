// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Use "transfer" instead of "call" to prevent reentrancy. The imposed gas limit of the instruction will not allow a reentrancy attack.
contract ReentrancyDAOFixedTransfer {
    
    mapping(address => uint) private balance;

    function deposit() external payable {
        balance[msg.sender] = msg.value;
    }

    function withdraw() external {
        uint addrBal = balance[msg.sender];
        payable(msg.sender).transfer(addrBal);
        balance[msg.sender] = 0;
    }
}