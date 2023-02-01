// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: The owner declares an ecrypter contract that will be used by all users.
//The owner must assume the responsability of checking the encrypter to make sure that it is not malicious.
contract CallToUnknownFixed {
    mapping(address => bytes) public messages;
    address private _encryptionProvider;

    constructor(address encryptionProvider) {
        _encryptionProvider = encryptionProvider;
    }

    function encryptMessage(string memory message)
        external
        returns (bytes memory)
    {
        (bool success, bytes memory encryptedText) = _encryptionProvider.call(
            abi.encodeWithSignature("encrypt(string)", message)
        );
        require(success, "Call to external contract failed");
        messages[msg.sender] = encryptedText;
        return encryptedText;
    }

    function decryptMessage(string memory message)
        external
        returns (bytes memory)
    {
        (bool success, bytes memory decryptedText) = _encryptionProvider.call(
            abi.encodeWithSignature("decrypt(string)", message)
        );
        require(success, "Call to external contract failed");
        return decryptedText;
    }
}
