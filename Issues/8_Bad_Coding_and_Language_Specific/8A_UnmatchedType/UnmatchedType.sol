// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract contains an assignment between an uint type and an enum type.
//Since the range of values for the uint variable is much larger, this could lead to unexpected results.
contract UnmatchedType {
    enum Options {
        Candidate1,
        Candidate2,
        Candidate3
    }
    mapping(address => Options) private _votes;
    mapping(Options => uint256) private _votesCount;

    function vote(uint256 option) external {
        _votes[msg.sender] = Options(option);
        _votesCount[Options(option)]++;
    }

    function getStatisticsForOption(uint256 option)
        external
        view
        returns (uint256)
    {
        return _votesCount[Options(option)];
    }
}
