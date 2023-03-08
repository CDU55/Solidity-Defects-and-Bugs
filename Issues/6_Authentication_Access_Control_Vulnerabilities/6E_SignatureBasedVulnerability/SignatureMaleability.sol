// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.17;

interface ECDSA {
   function recover(bytes32 hash, bytes memory signature) external returns (address);
   function toEthSignedMessageHash(bytes32 hash) external returns (bytes32);
}

contract SignatureMalleability {

    mapping (bytes => bool) private paid;
    address private owner;
    uint private share;
    ECDSA private ecdsa;
    address private admin;

    constructor (ECDSA _ecdsa, address _admin) payable {
        owner = msg.sender;
        share = msg.value;
        ecdsa = _ecdsa;
        admin = _admin;
    }

    function distribute(bytes memory signature) external {
        bytes memory mesg = abi.encodePacked("give me the money", msg.sender);
        // addr can be the same for different signatures
        // see: https://www.derpturkey.com/inherent-malleability-of-ecdsa-signatures/
        address addr = ecdsa.recover(
            ecdsa.toEthSignedMessageHash(keccak256(mesg)),
            signature
        );
        require(addr == admin); // replay admin
        require(!paid[signature]); // this remains be true for a different signature
        paid[signature] = true;
        payable(msg.sender).transfer(share); // paid again!
    }
}