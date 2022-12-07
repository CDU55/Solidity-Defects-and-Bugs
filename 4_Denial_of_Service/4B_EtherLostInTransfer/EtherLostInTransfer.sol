// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract EtherLostInTransfer{

    function Split(address[] calldata recepients) external payable
    {
        require(recepients.length>1,'You must specify two or more recepients');
        require(msg.value>0,'You must attach the currency that should be split');
        uint share=msg.value/recepients.length;
        for(uint recipientIndex=0;recipientIndex<recepients.length;recipientIndex++)
        {
            payable(recepients[recipientIndex]).transfer(share);
        }
    }
}