// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract does not contain a reason if "require" fails.
contract ReasonString {
    mapping(address => uint) private _balance;

    function deposit(uint amount) external payable {
        require(msg.value == amount);
        _balance[msg.sender] = amount;
    }

    //Obs: slither reentracy false positive
     function withdraw() external {
        uint toSend=_balance[msg.sender];
        require(_balance[msg.sender]!=0);
        _balance[msg.sender]=0;
        bool sent = payable(msg.sender).send(toSend);
        require(sent);
    }
}