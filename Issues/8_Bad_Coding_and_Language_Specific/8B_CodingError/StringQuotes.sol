// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//The strings are incapsulated in '', this is not recommended.
contract StringQuotes {
    function getSecretMessage(string calldata name)
        external
        pure
        returns (string memory)
    {
        return string(abi.encodePacked('Hello', ' ', name, '!'));
        //return string(string.concat(string.concat('Hello ', bytes(name)) ,'!'));
    }
}
