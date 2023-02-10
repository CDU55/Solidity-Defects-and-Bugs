// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: The owner declares an ecrypter contract that will be used by all users.
//The owner must assume the responsability of checking the encrypter to make sure that it is not malicious.
contract CallToUnknownFixed {
    mapping(address => bytes) public messages;
    address private encryptionProvider;

    constructor(address _encryptionProvider) {
        encryptionProvider = _encryptionProvider;
    }

    function encryptMessage(string memory message)
        external
        returns (bytes memory)
    {
        require(encryptionProvider != address(0));
        (bool success, bytes memory encryptedText) = encryptionProvider.call(
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
        require(encryptionProvider != address(0));
        (bool success, bytes memory decryptedText) = encryptionProvider.call(
            abi.encodeWithSignature("decrypt(string)", message)
        );
        require(success, "Call to external contract failed");
        return decryptedText;
    }
}
