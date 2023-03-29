// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract ReentrancySimple {
    mapping(address => uint) private balance;

    function deposit() external payable {
        balance[msg.sender] = msg.value;
    }

    function withdraw() external {
        uint addrBal = balance[msg.sender];
        uint gasLimit = gasleft();
        (bool success,) = payable(msg.sender).call{gas: gasLimit, value: addrBal}("");
        balance[msg.sender] = 0;
        require(success);
    }
}