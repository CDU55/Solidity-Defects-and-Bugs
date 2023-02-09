// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract ReentrancySimple {
    mapping(address => uint) private balance;

    function deposit() external payable {
        balance[msg.sender] = msg.value;
    }

    function withdraw() external {
        uint addrBal = balance[msg.sender];
        (bool success,) = payable(msg.sender).call{value: addrBal}("");
        // payable(msg.sender).transfer(addrBal);
        balance[msg.sender] = 0;
        require(success);
    }
}