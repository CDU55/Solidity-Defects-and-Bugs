// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Also add test case from https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/proxy/Proxy.sol
contract VulenerableDelegeateCALL{

    uint private vulnerableStorage;
    function forwardToWorker(address workerAddress,bytes calldata callData) public
    {
        executePreCallLogic();
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