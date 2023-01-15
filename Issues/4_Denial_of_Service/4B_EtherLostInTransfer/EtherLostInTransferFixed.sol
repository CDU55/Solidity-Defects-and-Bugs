// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Implement a "pull" mechanism. Record transactions during the initial split.
//After that, the benefactors can claim their ether or the doner can request a refund.
contract EtherLostInTransferFixed{

    struct Transaction{
        address from;
        address to;
        uint amount;
        bool isFinished;
    }

    Transaction[] private _recordedTransactions;
    mapping (address=>uint) receivers;
    event TransactionRegistered(address from, address to, uint amount);
    event TransactionRevoked(address from, address to, uint amount);

    function Split(address[] calldata recepients) external payable
    {
        require(recepients.length>1,"You must specify two or more recepients");
        require(msg.value>0,"You must attach the currency that should be split");
        uint share=msg.value/recepients.length;
        for(uint recepientIndex=0;recepientIndex<recepients.length;recepientIndex++)
        {
            _recordedTransactions.push(Transaction(msg.sender,recepients[recepientIndex],share,false));
            emit TransactionRegistered(msg.sender, recepients[recepientIndex], share);
        }
    }

    function withdraw() external
    {
        for(uint transactionIndex=0;transactionIndex<_recordedTransactions.length;transactionIndex++)
        {
            if(_recordedTransactions[transactionIndex].to==msg.sender)
            {
                payable(msg.sender).transfer(_recordedTransactions[transactionIndex].amount);
                _recordedTransactions[transactionIndex].isFinished=true;
                break;
            }
        }
    }

    function refund(address recepient) external
    {
        for(uint transactionIndex=0;transactionIndex<_recordedTransactions.length;transactionIndex++)
        {
            if(_recordedTransactions[transactionIndex].from==msg.sender && _recordedTransactions[transactionIndex].to==recepient)
            {
                payable(msg.sender).transfer(_recordedTransactions[transactionIndex].amount);
                _recordedTransactions[transactionIndex].isFinished=true;
                emit TransactionRevoked(msg.sender, recepient, _recordedTransactions[transactionIndex].amount);
                break;
            }
        }
    }
}