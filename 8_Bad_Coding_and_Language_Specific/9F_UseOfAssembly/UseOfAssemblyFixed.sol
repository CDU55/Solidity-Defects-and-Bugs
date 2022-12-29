// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract UseOfAssemblyFixed {
    mapping(address => uint) private balance;

    function deposit() external payable {
        balance[msg.sender] = msg.value;
    }

     function withdraw() external {
        uint toSend=balance[msg.sender];
        require(balance[msg.sender]!=0,'No balance found');
        balance[msg.sender]=0;
        (bool sent,) = payable(msg.sender).call{gas:2300,value: toSend}("");
        require(sent, "Failed to send Ether");
    }
}