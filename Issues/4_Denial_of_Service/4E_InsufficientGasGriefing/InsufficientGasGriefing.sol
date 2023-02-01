// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//The caller can intentionally send less gas than needed, but the trasaction will still be recorded as executed.
contract InsufficientGasGriefing {
    mapping(bytes => bool) executed;

    function execute(bytes calldata data, address worker)
        external
        returns (bool)
    {
        require(!executed[data], "This transaction has already been executed");
        executed[data] = true;
        (bool success, ) = payable(worker).call(
            abi.encodeWithSignature("execute(bytes)", data)
        );
        return success;
    }
}
