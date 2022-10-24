// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract CallToUnknown  {
    
    mapping(address=>bytes) public messages;
    mapping (address=>address) private encryptionProviders;
    function encryptMessage(string memory message,address encryptionProvider) external returns(bytes memory){
        (bool success,bytes memory encryptedText)=encryptionProvider.call(abi.encodeWithSignature("encrypt(string)", message));
        require(success,'Call to external contract failed');
        messages[msg.sender]=encryptedText;
        encryptionProviders[msg.sender]=encryptionProvider;
        return encryptedText;
    }

    function decryptMessage(string memory message) external returns(bytes memory){
        (bool success,bytes memory decryptedText)=encryptionProviders[msg.sender].call(abi.encodeWithSignature("decrypt(string)", message));
        require(success,'Call to external contract failed');
        return decryptedText;
    }
}


contract Encrypter
{
    event Text(string message);

    function encrypt(string calldata message) external returns(bytes memory)
    {
        emit Text(message);
        //Encrypt the message
        return abi.encodePacked('This is a malicious contract');
    }

    function decrypt(bytes calldata /*message*/) external pure returns(string memory)
    {
        return 'This is not malicious contract';
    }
}