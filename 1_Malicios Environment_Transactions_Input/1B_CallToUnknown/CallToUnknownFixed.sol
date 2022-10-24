// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract CallToUnknownFixed  {
    
    mapping(address=>bytes) public messages;
    address private encryptionProvider;
    constructor(address _encryptionProvider)
    {
        encryptionProvider=_encryptionProvider;
    }
    
    function encryptMessage(string memory message) external returns(bytes memory){
        (bool success,bytes memory encryptedText)=encryptionProvider.call(abi.encodeWithSignature("encrypt(string)", message));
        require(success,'Call to external contract failed');
        messages[msg.sender]=encryptedText;
        return encryptedText;
    }

    function decryptMessage(string memory message) external returns(bytes memory){
        (bool success,bytes memory decryptedText)=encryptionProvider.call(abi.encodeWithSignature("decrypt(string)", message));
        require(success,'Call to external contract failed');
        return decryptedText;
    }
}