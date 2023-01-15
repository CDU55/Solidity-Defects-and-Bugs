// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Check that the value of the uint parameter is in the value range of the enum
contract UnmatchedTypeFixed {
    enum Options{ Candidate1, Candidate2, Candidate3 }
    mapping(address => Options) private _votes;
    mapping(Options => uint) private _votesCount;

    function vote(uint option) external{
        require(option<=uint(Options.Candidate3),"Invalid Option");
        _votes[msg.sender]=Options(option);
        _votesCount[Options(option)]++;
    }

    function getStatisticsForOption(uint option) external view returns(uint){
        require(option<=uint(Options.Candidate3),"Invalid Option");
        return _votesCount[Options(option)];
    }
}