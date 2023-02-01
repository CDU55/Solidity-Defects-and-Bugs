// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Implement a commit mechanism, the user commits his encrypted answer.
//After all players commited their answers, they have must reveal them before a deadline is reached.
contract TransactionOrderDependencyFixed {
    struct CommitedAnswer {
        bytes32 commit;
        Options option;
        uint256 revealDeadline;
        bool deadlinePassed;
    }

    enum Options {
        Dove,
        Hawk,
        Default
    }

    enum States {
        GameStarted,
        FirstCommited,
        SecondCommited,
        FirstRevealed,
        SecondRevealed
    }

    constructor(uint256 _fee) {
        require(_fee % 2 == 0, "You must choose and even fee");
        entranceFee = _fee;
    }

    uint256 entranceFee;
    States public currentState = States.GameStarted;
    mapping(address => CommitedAnswer) answers;
    address[2] players;
    uint256 playerCount;

    function commit(bytes32 solution) external payable {
        require(msg.value >= entranceFee, "You must pay the register fee");
        if (currentState == States.GameStarted) {
            players[0] = msg.sender;
            answers[msg.sender] = CommitedAnswer(
                solution,
                Options.Default,
                0,
                false
            );
            currentState = States.FirstCommited;
            playerCount = playerCount + 1;
        } else if (currentState == States.FirstCommited) {
            players[1] = msg.sender;
            answers[msg.sender] = CommitedAnswer(
                solution,
                Options.Default,
                0,
                false
            );
            currentState = States.SecondCommited;
            playerCount = playerCount + 1;
        } else {
            revert("Players already joined");
        }
    }

    function reveal(bytes32 salt, Options option) external {
        if (currentState == States.SecondCommited && players[0] == msg.sender) {
            require(
                bytes32(abi.encodePacked(msg.sender, salt, option)) ==
                    answers[msg.sender].commit,
                "The provided values do not match the commit hash"
            );
            answers[msg.sender].option = option;
            answers[players[1]].revealDeadline = block.timestamp + 1 days;
            currentState = States.FirstRevealed;
        } else if (
            currentState == States.FirstRevealed && players[1] == msg.sender
        ) {
            if (block.timestamp > answers[msg.sender].revealDeadline) {
                require(
                    bytes32(abi.encodePacked(msg.sender, salt, option)) ==
                        answers[msg.sender].commit,
                    "The provided values do not match the commit hash"
                );
                answers[msg.sender].option = option;
                currentState = States.SecondRevealed;
            } else {
                answers[msg.sender].deadlinePassed = true;
            }
        } else {
            revert("You cannot reveal your option at this point");
        }
    }

    function checkWinner() external {
        require(
            currentState == States.SecondRevealed,
            "You cannot pick a winner at this state"
        );
        address player1 = players[0];
        address player2 = players[1];
        if (answers[player1].option == Options.Dove) {
            if (answers[player2].option == Options.Dove) {
                payable(player1).transfer(entranceFee + 1 ether);
                payable(player2).transfer(entranceFee + 1 ether);
            } else if (answers[player2].option == Options.Hawk) {
                payable(player1).transfer(entranceFee / 2);
                payable(player2).transfer(entranceFee + entranceFee / 2);
            }
        } else if (answers[player1].option == Options.Hawk) {
            if (answers[player2].option == Options.Dove) {
                payable(player1).transfer(entranceFee + entranceFee / 2);
                payable(player2).transfer(entranceFee / 2);
            }
        }

        if (answers[player2].deadlinePassed == true) {
            payable(player1).transfer(entranceFee + entranceFee * 2);
        }

        resetState();
    }

    function resetState() private {
        currentState = States.GameStarted;
        playerCount = 0;
    }
}
