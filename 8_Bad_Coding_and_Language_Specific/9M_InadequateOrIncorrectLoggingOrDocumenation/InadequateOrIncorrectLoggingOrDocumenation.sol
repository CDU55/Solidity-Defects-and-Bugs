// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract InadequateOrIncorrectLoggingOrDocumenation
{
    event Received(address to, address from, uint amount);
     struct Transaction{
        address from;
        address to;
        uint amount;
        bool isFinished;
    }

    Transaction[] private recordedTransactions;
    mapping (address=>uint) receivers;
    event TransactionRegistered(address from, address to, uint amount);
    event TransactionRevoked(address from, address to, uint amount);

    function Split(address[] calldata recepients) external payable
    {
        require(recepients.length>1,'You must specify two or more recepients');
        require(msg.value>0,'You must attach the currency that should be split');
        uint share=msg.value/recepients.length;
        for(uint recepientIndex=0;recepientIndex<recepients.length;recepientIndex++)
        {
            recordedTransactions.push(Transaction(msg.sender,recepients[recepientIndex],share,false));
            emit TransactionRegistered(msg.sender, recepients[recepientIndex], share);
        }
    }

    function withdraw() external
    {
        for(uint transactionIndex=0;transactionIndex<recordedTransactions.length;transactionIndex++)
        {
            if(recordedTransactions[transactionIndex].to==msg.sender)
            {
                emit Received(recordedTransactions[transactionIndex].to,recordedTransactions[transactionIndex].from,recordedTransactions[transactionIndex].amount);
                payable(msg.sender).transfer(recordedTransactions[transactionIndex].amount);
                recordedTransactions[transactionIndex].isFinished=true;
                break;
            }
        }
    }

    function refund(address recepient) external
    {
        for(uint transactionIndex=0;transactionIndex<recordedTransactions.length;transactionIndex++)
        {
            if(recordedTransactions[transactionIndex].from==msg.sender && recordedTransactions[transactionIndex].to==recepient)
            {
                payable(msg.sender).transfer(recordedTransactions[transactionIndex].amount);
                recordedTransactions[transactionIndex].isFinished=true;
                emit TransactionRevoked(msg.sender, recepient, recordedTransactions[transactionIndex].amount);
                break;
            }
        }
    }
}