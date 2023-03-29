// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Also add test case from https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/proxy/Proxy.sol
//This contract uses other contracts for it's main logic, it only containg "before" and "after" callbacks.
//The worker can be any contract provided by the user. Since "delegatecall" is used, providing a malicious contract can be really damaging for the state fo the contract.
contract VulnerableDelegeateCALL {
    uint256 private vulnerableStorage;

    function forwardToWorker(address workerAddress, bytes calldata callData)
        public
    {
        executePreCallLogic();
        (bool success, ) = workerAddress.delegatecall(callData);
        require(success);
        executePostCallLogic();
    }

    function executePreCallLogic() private {
        //Do some logic
    }

    function executePostCallLogic() private {
        //Do some logic
    }
}
