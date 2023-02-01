// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Check if the user sent enough gas to esxecute the transaction
contract InsufficientGasGriefingFixed {
    mapping(bytes => bool) executed;

    function execute(bytes calldata data, address worker)
        external
        returns (bool)
    {
        require(!executed[data], "This transaction has already been executed");
        (bool gasCallSuccess, bytes memory gasBytes) = payable(worker).call(
            abi.encodeWithSignature("getGasLimit()")
        );
        require(gasCallSuccess, "Cannot get gas limit");
        require(gasBytes.length == 32, "Invalid result format");
        uint256 gasLimit = uint256(bytes32(gasBytes));
        require(gasleft() < gasLimit, "Insufficient gas");

        executed[data] = true;
        (bool success, ) = payable(worker).call(
            abi.encodeWithSignature("execute(bytes)", data)
        );
        return success;
    }
}
