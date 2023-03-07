// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Use "msg.sender" instead of "tx.origin".
contract TransactionStateDependencyFixed {
    address private owner;

    modifier onlyOwner() {
        require(
            msg.sender == owner,
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
