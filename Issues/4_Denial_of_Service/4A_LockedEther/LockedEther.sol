// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract has a payble function, thus can receive Ether. However, it does not define a function to transfer the Ether.
contract LockedEther {
    mapping(address => uint256) private _balance;

    function deposit(uint256 amount) external payable {
        require(msg.value == amount, "Incorrect amount");
        _balance[msg.sender] = amount;
    }
}
