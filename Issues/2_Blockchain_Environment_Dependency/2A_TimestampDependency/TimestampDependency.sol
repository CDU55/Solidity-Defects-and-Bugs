// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract rewards the users that call the "play" method during a certain window of time.
//However, it relies on block.timestamp, which can be influenced by miners.
contract TimestampDependency  {
    address private _owner;
    uint private _gameStartTime;
    uint private _gameEndTime;
    uint public fee;

    event GameStarted(uint timestamp);

    modifier onlyOwner() {
        require(msg.sender == _owner, "Only the owner of the contract can access this");
        _;
    }

    constructor(uint _fee)
    {
        _owner=msg.sender;
        fee=_fee;
    }

    function startGame() external onlyOwner{
        _gameStartTime=block.timestamp;
        _gameEndTime=_gameStartTime + 15 seconds;
        emit GameStarted(block.timestamp);
    }

    function play() external payable returns(bool){
        require(msg.value>=fee,"You must pay the fee required to play");
        if(block.timestamp>=_gameStartTime && block.timestamp<=_gameEndTime)
        {
            payable(msg.sender).transfer(10*fee);
            return true;
        }
        else
        {
            return false;
        }
    }


}