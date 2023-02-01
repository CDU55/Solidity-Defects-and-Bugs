// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract uses "memory" instead of "calldata". The difference in price for opcodes for "memory" and "calldata" is not that big, but it might be in the future.
contract UnderPricedOpcodes {
    function performHash(string memory secret)
        external
        pure
        returns (bytes32 secretHashed)
    {
        return keccak256(abi.encode(secret));
    }
}
