// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Revert does not contain a reason.
contract ReasonStringRevert {
    mapping(address => uint) private _balance;

    function deposit(uint amount) external payable {
        if(msg.value!=amount)
        {
            revert();
        }
        _balance[msg.sender] = amount;
    }

    function withdraw() external {
        uint toSend=_balance[msg.sender];
        if(_balance[msg.sender]==0)
        {
            revert();
        }
        _balance[msg.sender]=0;
        bool sent = payable(msg.sender).send(toSend);
        if(!sent){
            revert();
        }
    }
}