// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Since the "transfer" method is locked at 2300 gas, it could easily produce an out-of-gas excepion if the currency is sent to a smart contract with a complex callback.
contract MishandledOutOfGasException {
    mapping(address => uint256) borrowers;

    function borrow(uint256 amount) external {
        require(address(this).balance > amount, "Not enough funds");
        borrowers[msg.sender] += (amount + 1 ether);
        payable(msg.sender).transfer(amount);
    }

    function payDebt() external payable {
        require(
            msg.value >= borrowers[msg.sender],
            "Insufficient amount attached to the call"
        );
        borrowers[msg.sender] = 0;
    }
}
