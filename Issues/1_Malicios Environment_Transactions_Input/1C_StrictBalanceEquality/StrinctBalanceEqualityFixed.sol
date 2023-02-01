// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Do not use an equality operator when comparing the balance of the contract.
contract StrinctBalanceEqualityFixed {
    address private _owner;

    modifier onlyOwner() {
        require(
            msg.sender == _owner,
            "Only the owner of the contract can access this"
        );
        _;
    }

    constructor() {
        _owner = msg.sender;
    }

    receive() external payable {}

    function getFunds() external onlyOwner {
        require(
            address(this).balance > 10 ether,
            "The funding goal has not been reached"
        );
        payable(_owner).transfer(address(this).balance);
    }
}
