// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.17;

interface ECDSA {
   function recover(bytes32 hash, bytes memory signature) external returns (address);
   function toEthSignedMessageHash(bytes32 hash) external returns (bytes32);
}

contract SignatureMalleability {

    mapping (bytes => bool) private paid;
    mapping (address => uint) private nonces;
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

    function distribute(bytes memory signature, uint nonce) external {
        bytes memory mesg = abi.encodePacked("give me the money", msg.sender, nonce);
        address addr = ecdsa.recover(
            ecdsa.toEthSignedMessageHash(keccak256(mesg)),
            signature
        );
        require(nonces[addr] == 0);
        require(addr == admin); 
        require(!paid[signature]); 
        paid[signature] = true;
        nonces[addr] = nonce;
        payable(msg.sender).transfer(share);
    }
}