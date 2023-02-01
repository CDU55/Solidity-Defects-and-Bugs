// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//The "Received" event is emitted before the transfer is executed. If the transfer fails, the event would be falsely emitted.
contract InadequateOrIncorrectLoggingOrDocumenation {
    event Received(address to, address from, uint256 amount);
    struct Transaction {
        address from;
        address to;
        uint256 amount;
        bool isFinished;
    }

    Transaction[] private _recordedTransactions;
    mapping(address => uint256) receivers;
    event TransactionRegistered(address from, address to, uint256 amount);
    event TransactionRevoked(address from, address to, uint256 amount);

    function Split(address[] calldata recepients) external payable {
        require(
            recepients.length > 1,
            "You must specify two or more recepients"
        );
        require(
            msg.value > 0,
            "You must attach the currency that should be split"
        );
        uint256 share = msg.value / recepients.length;
        for (
            uint256 recepientIndex = 0;
            recepientIndex < recepients.length;
            recepientIndex++
        ) {
            _recordedTransactions.push(
                Transaction(
                    msg.sender,
                    recepients[recepientIndex],
                    share,
                    false
                )
            );
            emit TransactionRegistered(
                msg.sender,
                recepients[recepientIndex],
                share
            );
        }
    }

    function withdraw() external {
        for (
            uint256 transactionIndex = 0;
            transactionIndex < _recordedTransactions.length;
            transactionIndex++
        ) {
            if (_recordedTransactions[transactionIndex].to == msg.sender) {
                emit Received(
                    _recordedTransactions[transactionIndex].to,
                    _recordedTransactions[transactionIndex].from,
                    _recordedTransactions[transactionIndex].amount
                );
                payable(msg.sender).transfer(
                    _recordedTransactions[transactionIndex].amount
                );
                _recordedTransactions[transactionIndex].isFinished = true;
                break;
            }
        }
    }

    function refund(address recepient) external {
        for (
            uint256 transactionIndex = 0;
            transactionIndex < _recordedTransactions.length;
            transactionIndex++
        ) {
            if (
                _recordedTransactions[transactionIndex].from == msg.sender &&
                _recordedTransactions[transactionIndex].to == recepient
            ) {
                payable(msg.sender).transfer(
                    _recordedTransactions[transactionIndex].amount
                );
                _recordedTransactions[transactionIndex].isFinished = true;
                emit TransactionRevoked(
                    msg.sender,
                    recepient,
                    _recordedTransactions[transactionIndex].amount
                );
                break;
            }
        }
    }
}
