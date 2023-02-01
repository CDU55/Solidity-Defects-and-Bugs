// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//This contract uses floating pragma
contract FloatingPragma {
    mapping(address => uint256) private _balance;

    function deposit() external payable {
        _balance[msg.sender] = msg.value;
    }

    function withdraw() external {
        require(_balance[msg.sender] != 0, "No balance found");
        uint256 toSend = _balance[msg.sender];
        payable(msg.sender).transfer(toSend);
        _balance[msg.sender] = 0;
    }
}
