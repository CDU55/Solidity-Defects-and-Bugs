// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: use a specific Solidity version
contract FloatingPragma {
    mapping(address => uint256) private balance;

    function deposit() external payable {
        balance[msg.sender] = msg.value;
    }

    function withdraw() external {
        require(balance[msg.sender] != 0, "No balance found");
        uint256 toSend = balance[msg.sender];
        payable(msg.sender).transfer(toSend);
        balance[msg.sender] = 0;
    }
}
