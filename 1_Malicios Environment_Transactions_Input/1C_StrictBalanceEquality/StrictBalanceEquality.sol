// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//The "getFunds" method uses strict equality when comparing the current balance. If the balance goes from a lower point to a higher point, the equality will never be reached.
contract StrictBalanceEquality{

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
        require(address(this).balance==10 ether,'The funding goal has not been reached');
        payable(owner).transfer(address(this).balance);
    }
}