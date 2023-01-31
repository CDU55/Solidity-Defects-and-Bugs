// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract contains a "DAO-like" reentrancy vulnerability
contract ReentrancyDAO {
    mapping(address => uint) private balance;

    function deposit() external payable {
        balance[msg.sender] = msg.value;
    }

    function withdraw() external {
        uint addrBal = balance[msg.sender];
        (bool success,) = payable(msg.sender).call{value: addrBal}("");
        balance[msg.sender] = 0;
        require(success);
    }
}