// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract uses another contract to encrypt and decrypt messages via the "call" primitive.
//However, the encrypter contract can be any contract provided by the user, including malicious ones.
contract CallToUnknownSimple {

    function foo(string memory data, address provider)
        external
        returns (bytes memory)
    {
        require(provider != address(0));
        (bool success, bytes memory processed) = provider.call(
            abi.encodeWithSignature("process(string)", data)
        );
        require(success, "Call to external contract failed");
        return processed;
    }
}

contract Provider {
    event Text(string message);

    function process(string calldata data) external returns (bytes memory) {
        emit Text(data);
        // Process the input
        return abi.encodePacked("This is a malicious contract");
    }
}