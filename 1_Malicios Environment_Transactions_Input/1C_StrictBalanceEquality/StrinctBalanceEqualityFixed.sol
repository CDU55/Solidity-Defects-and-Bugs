// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Fix: Do not use an equality operator when comparing the balance of the contract.
contract StrinctBalanceEqualityFixed{

    address private owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner of the contract can access this");
        _;
    }

    constructor()
    {
        owner=msg.sender;
    }

    receive() external payable {

    }

    function getFunds() external onlyOwner{
        require(address(this).balance>10 ether,'The funding goal has not been reached');
        payable(owner).transfer(address(this).balance);
    }
}