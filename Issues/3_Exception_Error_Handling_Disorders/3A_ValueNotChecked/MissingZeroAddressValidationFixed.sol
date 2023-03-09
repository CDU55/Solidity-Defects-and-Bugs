// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract MissingZeroCheck {
    address private owner;

    modifier onlyOwner {
        require(owner == msg.sender);
        _;
    }    

    function changeOwnerTo(address newOwner) external onlyOwner {
        require(newOwner != address(0));
        owner = newOwner;
    }
}
