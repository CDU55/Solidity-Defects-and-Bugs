// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Use the "call" primitive with all the gas provided by the caller.
contract MishandledOutOfGasExceptionFixed {
    mapping(address => uint256) borrowers;

    function borrow(uint256 amount) external {
        require(address(this).balance > amount, "Not enough funds");
        borrowers[msg.sender] += (amount + 1 ether);
        (bool success, ) = payable(msg.sender).call{
            value: amount,
            gas: gasleft()
        }("");
        if (!success) {
            revert("Could not send funds");
        }
    }

    function payDebt() external payable {
        require(
            msg.value >= borrowers[msg.sender],
            "Insufficient amount attached to the call"
        );
        borrowers[msg.sender] = 0;
    }
}
