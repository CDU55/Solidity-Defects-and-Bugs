// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract DenialOfServiceGasLimitBets {
    address private owner;
    enum Status {
        OPEN,
        CLOSED,
        FINISHED
    }
    Status private state;
    uint public count;
    uint private threshold;
    uint private amount;
    address[] public players;
    uint[] public bets;
    mapping(address => bool) private winningBets;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    constructor(uint _threshold) {
        owner = msg.sender;
        count = 0;
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
        players[count] = msg.sender;
        bets[count] = value;
        count = count + 1;
        winningBets[msg.sender] = false;
    }

    function close(uint score) external onlyOwner {
        require(state == Status.OPEN);
        require(address(this).balance > 0);
        state = Status.FINISHED;
        uint winners = 0;
        // counting the winners requires a loop
        for (uint i = 0; i < count; i++) { // count can get large
            if (bets[i] == score) {
                winningBets[players[i]] = true;
                winners = winners + 1;
            }
        }
        amount = address(this).balance / winners;
        delete players;
        delete bets;
    }

    function withdraw() external {
        require(state == Status.FINISHED);
        require(winningBets[msg.sender]);
        winningBets[msg.sender] = false;
        payable(msg.sender).transfer(amount);
    }
}
