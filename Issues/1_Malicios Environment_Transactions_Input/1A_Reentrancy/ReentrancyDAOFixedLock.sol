// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Use a lock mechanism to prevent reentrancy
//Using the lock pattern to try and trick the analysis tools
contract ReentrancyDAOFixedLock {

    mapping(address => uint) private balance;
    bool private lockedWithdraw;

    function deposit() external payable {
        balance[msg.sender] = msg.value;
    }

    function withdraw() external {
        require(balance[msg.sender] >= 0);
        require(!lockedWithdraw);
        lockedWithdraw = true;
        uint addrBal = balance[msg.sender];
        (bool sent,) = payable(msg.sender).call{value: addrBal}("");
        require(sent, "Failed to send Ether");
        balance[msg.sender] = 0;
        lockedWithdraw = false;
    }
}