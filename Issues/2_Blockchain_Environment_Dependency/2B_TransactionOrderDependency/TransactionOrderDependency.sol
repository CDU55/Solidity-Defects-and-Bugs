// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract contains a game where a player chooses an option.
//A miner can see the option that a player chose and "steal" the answer by manipulating the order of transactions and putting his call first.
contract TransactionOrderDependencyFixed {
    enum Options {
        Dove,
        Hawk,
        Default
    }

    enum States {
        GameStarted,
        FirstCommited,
        SecondCommited
    }

    uint256 entranceFee;
    States public currentState = States.GameStarted;
    mapping(address => Options) answers;
    address[2] players;
    uint256 playerCount;

    constructor(uint256 _fee) {
        require(_fee % 2 == 0, "You must choose and even fee");
        entranceFee = _fee;
    }

    function commit(Options option) external payable {
        require(msg.value >= entranceFee, "You must pay the register fee");
        if (currentState == States.GameStarted) {
            players[0] = msg.sender;
            answers[msg.sender] = option;
            currentState = States.FirstCommited;
            playerCount = playerCount + 1;
        } else if (currentState == States.FirstCommited) {
            players[1] = msg.sender;
            answers[msg.sender] = option;
            currentState = States.SecondCommited;
            playerCount = playerCount + 1;
        } else {
            revert("Players already joined");
        }
    }

    function checkWinner() external {
        require(
            currentState == States.SecondCommited,
            "You cannot pick a winner at this state"
        );
        address player1 = players[0];
        address player2 = players[1];
        if (answers[player1] == Options.Dove) {
            if (answers[player2] == Options.Dove) {
                payable(player1).transfer(entranceFee + 1 ether);
                payable(player2).transfer(entranceFee + 1 ether);
            } else if (answers[player2] == Options.Hawk) {
                payable(player1).transfer(entranceFee / 2);
                payable(player2).transfer(entranceFee + entranceFee / 2);
            }
        } else if (answers[player1] == Options.Hawk) {
            if (answers[player2] == Options.Dove) {
                payable(player1).transfer(entranceFee + entranceFee / 2);
                payable(player2).transfer(entranceFee / 2);
            }
        }

        resetState();
    }

    function resetState() private {
        currentState = States.GameStarted;
        playerCount = 0;
    }
}
