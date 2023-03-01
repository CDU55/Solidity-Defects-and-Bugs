// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract DenialOfServiceGasLimitBets {
    address private owner;
    uint private threshold;
    uint private amount;
    uint private winningScore;
    mapping(address => uint) public bets;
    mapping(uint => uint) public betsCount;
    enum Status {
        OPEN,
        CLOSED,
        FINISHED
    }
    Status private state;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    constructor(uint _threshold) {
        owner = msg.sender;
        amount = 0;
        threshold = _threshold;
        state = Status.CLOSED;
    }

    function open() external onlyOwner {
        require(state == Status.CLOSED);
        state = Status.OPEN;
    }

   
    function bet(uint value) external payable {
        require(state == Status.OPEN);
        require(msg.value == threshold);
        betsCount[value] = betsCount[value] + 1;
        bets[msg.sender] = value;
    }

    function close(uint score) external onlyOwner {
        require(state == Status.OPEN);
        require(betsCount[score] > 0);
        state = Status.FINISHED;
        amount = address(this).balance / betsCount[score];
        winningScore = score;
    }

    function withdraw() external {
        require(state == Status.FINISHED);
        require(bets[msg.sender] == winningScore);
        delete bets[msg.sender];
        payable(msg.sender).transfer(amount);
    }
}
