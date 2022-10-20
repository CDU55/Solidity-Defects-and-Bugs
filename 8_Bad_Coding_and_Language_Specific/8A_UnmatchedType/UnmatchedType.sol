// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//This contract contains an assignment between an uint type and an enum type.
//Since the range of values for the uint variable is much larger, this could lead to unexpected results.
contract UnmatchedType {
    enum Options{ Candidate1, Candidate2, Candidate3 }
    mapping(address => Options) private votes;
    mapping(Options => uint) private votesCount;

    function vote(uint option) external{
        votes[msg.sender]=Options(option);
        votesCount[Options(option)]++;
    }

    function getStatisticsForOption(uint option) external view returns(uint){
        return votesCount[Options(option)];
    }
}