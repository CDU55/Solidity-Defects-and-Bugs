// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract UnderPricedOpcodes{

    function performHash(string memory secret) external pure returns(bytes32 secretHashed)
    {
        return keccak256(abi.encode(secret));
    }

}