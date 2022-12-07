// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//This contract contains a public function that could be declared a external
contract HighConsumptionDataFunctionType {
  
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

    function transferBalance() onlyOwner public{
        payable(owner).transfer(address(this).balance);
    }
}