// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract contains a "DAO-like" reentrancy vulnerability
contract ReentrancyDAO {
    mapping(address => uint256) private _balance;

    function deposit() external payable {
        _balance[msg.sender] = msg.value;
    }

    function withdraw() external {
        require(_balance[msg.sender] != 0, "No balance found");
        uint256 toSend = _balance[msg.sender];
        payable(msg.sender).call{value: toSend}("");
        _balance[msg.sender] = 0;
    }
}
