// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ImproperDataValidationFixed {


    mapping(address=>uint) participants;
    uint private someNumber;
    uint private prize;
    uint private fee;
    bool private gameEnded;


    constructor(uint _someNumber,uint _prize,uint _fee) payable
    {
        require(msg.value==prize,'Provide currency equal to the declared prize');
        someNumber=_someNumber;
        prize=_prize;
        fee=_fee;
    }

    function participate(uint validateMe) payable external
    {
        //Also perform inline validation
        require(isValid(validateMe),'Invalid option');
        require(msg.value==fee,'Please attach the correct fee');
        require(participants[msg.sender]==0,'You already participated');
        require(!gameEnded,'The game has ended');
        if(someNumber==0)
        {
            payable(msg.sender).transfer(prize);
            gameEnded=true;
        }
        else
        {
            participants[msg.sender]=1;
            modifyState(validateMe);
        }
    }

    function isWinner(uint option) view private returns(bool)
    {
        //Test if the option is a winning one
        return (someNumber/option)==1;
    }

    function isValid(uint option) view private returns(bool)
    {
        return option>0 && option<someNumber;
    }

    function modifyState(uint option) private{
        someNumber=someNumber/option;
    }

}