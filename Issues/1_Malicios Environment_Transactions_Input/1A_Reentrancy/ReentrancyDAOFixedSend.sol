// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

// Fix: Use "send" instead of "call" to prevent reentrancy. 
// The imposed gas limit of the instruction will not allow a reentrancy attack.
contract ReentrancyDAOFixedSend {
    mapping(address => uint) private balance;

    function deposit() external payable {
        balance[msg.sender] = msg.value;
    }

    function withdraw() external {
        uint addrBal = balance[msg.sender];
        bool success = payable(msg.sender).send(addrBal);
        balance[msg.sender] = 0;
        require(success);
    }
}