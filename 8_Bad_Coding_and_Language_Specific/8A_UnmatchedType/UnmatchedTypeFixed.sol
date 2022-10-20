// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Fix: Check that the value of the uint parameter is in the value range of the enum
contract UnmatchedTypeFixed {
    enum Options{ Candidate1, Candidate2, Candidate3 }
    mapping(address => Options) private votes;
    mapping(Options => uint) private votesCount;

    function vote(uint option) external{
        require(option<=uint(Options.Candidate3),'Invalid Option');
        votes[msg.sender]=Options(option);
        votesCount[Options(option)]++;
    }

    function getStatisticsForOption(uint option) external view returns(uint){
        require(option<=uint(Options.Candidate3),'Invalid Option');
        return votesCount[Options(option)];
    }
}