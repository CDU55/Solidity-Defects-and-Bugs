// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract MishandledOutOfGasException{

    mapping(address=>uint) borrowers;

    function borrow(uint amount) external
    {
        require(address(this).balance>amount,'Not enough funds');
        borrowers[msg.sender]+=(amount+1 ether);
        payable(msg.sender).transfer(amount);
    }

    function payDebt() external payable
    {
        require(msg.value>=borrowers[msg.sender],'Insufficient amount attached to the call');
        borrowers[msg.sender]=0;
    }
}