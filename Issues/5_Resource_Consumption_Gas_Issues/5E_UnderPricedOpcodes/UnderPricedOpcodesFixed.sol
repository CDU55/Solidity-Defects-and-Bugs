// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Use "calldata".
contract UnderPricedOpcodesFixed {
    function performHash(string calldata secret)
        external
        pure
        returns (bytes32 secretHashed)
    {
        return keccak256(abi.encode(secret));
    }
}
