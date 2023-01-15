// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//The value returned by the "send" instruction from the "withdraw" method is not checked.
contract ValueNotChecked {
    mapping(address => uint) private _balance;
    bool internal lockedWithdraw;

    function deposit(uint amount) external payable {
        require(msg.value == amount, "Incorrect amount");
        _balance[msg.sender] = amount;
    }

    //Obs: slither reentracy false positive
     function withdraw() external {
        require(_balance[msg.sender]!=0,"No balance found");
        require(!lockedWithdraw,"A withdraw operation is already in progress, please wait");
        lockedWithdraw=true;
        uint toSend=_balance[msg.sender];
        payable(msg.sender).send(toSend);
        _balance[msg.sender]=0;
        lockedWithdraw=false;
    }
}