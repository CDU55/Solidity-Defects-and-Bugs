// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
//Fix: The owner manages a list of safe players, only those on the list are allowed to play.
contract TimestampDependencyFixed  {
    address private _owner;
    uint private _gameStartTime;
    uint private _gameEndTime;
    uint public fee;
    mapping(address=>uint) private _safePlayers;

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

    function addSafePlayer(address player) onlyOwner external{
        _safePlayers[player]=1;
    }

     function removeSafePlayer(address player) onlyOwner external{
        _safePlayers[player]=0;
    }

    function startGame(uint timestamp) external onlyOwner{
        _gameStartTime=timestamp;
        _gameEndTime=_gameStartTime + 15 seconds;
        emit GameStarted(timestamp);
    }

    function play(uint timestamp) external payable returns(bool){
        require(msg.value>=fee,"You must pay the fee required to play");
        require(_safePlayers[msg.sender]==1,"Only registered addresses can play");
        if(timestamp>=_gameStartTime && timestamp<=_gameEndTime)
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