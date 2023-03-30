// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: The owener of the contract is in charge of maintaining a list of accepted workers. Only the workers from that list can be used.
contract VulnerableDelegeateCALLFixed {
    mapping(address => int256) private acceptedWorkers;

    address private owner;

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only the owner of the contract can access this"
        );
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addAcceptedWorker(address worker) external onlyOwner {
        acceptedWorkers[worker] = 1;
    }

    function removeAcceptedWorker(address worker) external onlyOwner {
        acceptedWorkers[worker] = 0;
    }

    function forwardToWorker(address workerAddress, bytes calldata callData)
        public
    {
        require(
            acceptedWorkers[workerAddress] == 1,
            "The provided address is not featured on the workers whitelist"
        );
        executePostCallLogic();
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
