// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract VulenerableDelegeateCALL{

    function forwardToWorker(address workerAddress,bytes calldata callData) public
    {
        executePostCallLogic();
        (bool success,)=workerAddress.delegatecall(callData);
        require(success);
        executePostCallLogic();
    }

    function executePreCallLogic() private{
        //Do some logic
    }

    function executePostCallLogic() private{
        //Do some logic
    }
}