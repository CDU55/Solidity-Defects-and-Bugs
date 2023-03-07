// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract uses the transaction origin to determine if the caller is the owner of the contract.
contract TransactionStateDependency {
    address owner;

    modifier onlyOwner() {
        require(
            tx.origin == owner,
            "Only the owner of the contract can access this"
        );
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    function transferBalance() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}
