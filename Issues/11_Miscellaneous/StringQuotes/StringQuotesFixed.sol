// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Use "" for strings.
contract StringQuotesFixed {
    function getSecretMessage(string calldata name)
        external
        pure
        returns (string memory)
    {
        return string(abi.encodePacked("Hello", " ", name, "!"));
        //return string(string.concat(string.concat('Hello ', bytes(name)) ,'!'));
    }
}
