// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract ReentrancySimple {
    mapping(address => uint) private balance;
    bool internal locked;

    modifier unlocked() {
        require(!locked);
        locked = true;
        _;
        locked = false;
    }

    function deposit() external payable {
        balance[msg.sender] = msg.value;
    }

    function withdraw() external unlocked {
        uint addrBal = balance[msg.sender];
        (bool success,) = payable(msg.sender).call{value: addrBal}("");
        balance[msg.sender] = 0;
        require(success);
    }
}