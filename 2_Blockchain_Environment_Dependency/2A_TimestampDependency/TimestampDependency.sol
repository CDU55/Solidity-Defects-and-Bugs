// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract TimestampDependency  {
    address private owner;
    uint private gameStartTime;
    uint private gameEndTime;
    uint public fee;

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

    function startGame() external onlyOwner{
        gameStartTime=block.timestamp;
        gameEndTime=gameStartTime + 15 seconds;
        emit GameStarted(block.timestamp);
    }

    function play() external payable returns(bool){
        require(msg.value>=fee,'You must pay the fee required to play');
        if(block.timestamp>=gameStartTime && block.timestamp<=gameEndTime)
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