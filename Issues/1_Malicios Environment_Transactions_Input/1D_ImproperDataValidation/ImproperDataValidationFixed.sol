// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Validate the input at the begging of the "participate" method.
contract ImproperDataValidationFixed {

    mapping(address=>uint) participants;
    uint private _someNumber;
    uint private _prize;
    uint private _fee;
    bool private _gameEnded;


    constructor(uint someNumber,uint prize,uint fee) payable
    {
        require(msg.value==prize,"Provide currency equal to the declared prize");
        _someNumber=someNumber;
        _prize=prize;
        _fee=fee;
    }

    function participate(uint validateMe) payable external
    {
        //Also perform inline validation
        require(isValid(validateMe),"Invalid option");
        require(msg.value==_fee,"Please attach the correct fee");
        require(participants[msg.sender]==0,"You already participated");
        require(!_gameEnded,"The game has ended");
        if(isWinner(validateMe))
        {
            payable(msg.sender).transfer(_prize);
            _gameEnded=true;
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
        return (_someNumber<=option) || (_someNumber/option)==1;
    }

    function isValid(uint option) view private returns(bool)
    {
        return option>0 && option<_someNumber;
    }

    function modifyState(uint option) private{
        _someNumber=_someNumber/option;
    }

}