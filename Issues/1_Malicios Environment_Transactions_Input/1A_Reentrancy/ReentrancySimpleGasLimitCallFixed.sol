// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract ReentrancySimple {
    mapping(address => uint) private balance;

    function deposit() external payable {
        balance[msg.sender] = msg.value;
    }

    function withdraw() external {
        uint addrBal = balance[msg.sender];
        uint gasLimit = 2300;
        (bool success,) = payable(msg.sender).call{gas: gasLimit, value: addrBal}("");
        balance[msg.sender] = 0;
        require(success);
    }
}