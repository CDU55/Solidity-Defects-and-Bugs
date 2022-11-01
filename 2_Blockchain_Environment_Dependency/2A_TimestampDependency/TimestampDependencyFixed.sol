// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract TimestampDependencyFixed  {
    address private owner;
    uint private gameStartTime;
    uint private gameEndTime;
    uint public fee;
    mapping(address=>uint) private safePlayers;

    event GameStarted(uint timestamp);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner of the contract can access this");
        _;
    }

    constructor(uint _fee)
    {
        owner=msg.sender;
        fee=_fee;
    }

    function addSafePlayer(address player) onlyOwner external{
        safePlayers[player]=1;
    }

     function removeSafePlayer(address player) onlyOwner external{
        safePlayers[player]=0;
    }

    function startGame(uint timestamp) external onlyOwner{
        gameStartTime=timestamp;
        gameEndTime=gameStartTime + 15 seconds;
        emit GameStarted(timestamp);
    }

    function play(uint timestamp) external payable returns(bool){
        require(msg.value>=fee,'You must pay the fee required to play');
        require(safePlayers[msg.sender]==1,'Only registered addresses can play');
        if(timestamp>=gameStartTime && timestamp<=gameEndTime)
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