// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Use a lock mechanism to prevent reentrancy
//Using the lock pattern to try and trick the analysis tools
contract ReentrancyDAOFixedLock {

    mapping(address => uint) private _balance;
    bool private _lockedWithdraw;

    function deposit() external payable {
        _balance[msg.sender] = msg.value;
    }

    function withdraw() external {
        require(_balance[msg.sender]!=0,"No balance found");
        require(!_lockedWithdraw,"A withdraw operation is already in progress, please wait");
        _lockedWithdraw=true;
        uint toSend=_balance[msg.sender];
        (bool sent,) = payable(msg.sender).call{value: toSend}("");
        require(sent, "Failed to send Ether");
        _balance[msg.sender]=0;
        _lockedWithdraw=false;
    }
}