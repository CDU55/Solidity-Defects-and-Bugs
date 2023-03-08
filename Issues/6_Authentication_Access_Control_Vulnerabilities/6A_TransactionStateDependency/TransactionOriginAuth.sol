// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract uses the transaction origin to determine if the caller is the owner of the contract.
contract TransactionStateDependency {
    address owner;
    mapping (address => bool) registered;

    constructor() {
        owner = msg.sender;
    }

    function register() external {
        registered[msg.sender] = true;
    }

    function distribute(address recipient, uint share) external {
        require(tx.origin == owner);
        require(registered[recipient]);
        payable(recipient).transfer(share);
    }
}
