// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Fix: set the balance of the current use equal to 0 before the transfer
contract ReentrancyDAOFixed {
    mapping(address => uint) private balance;

    function deposit() external payable {
        balance[msg.sender] = msg.value;
    }

     function withdraw() external {
        uint toSend=balance[msg.sender];
        require(balance[msg.sender]!=0,'No balance found');
        balance[msg.sender]=0;
        (bool sent,) = payable(msg.sender).call{value: toSend}("");
        require(sent, "Failed to send Ether");
    }
}