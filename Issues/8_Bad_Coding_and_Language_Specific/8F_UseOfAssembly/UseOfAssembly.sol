// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract uses assembly
contract UseOfAssembly {
    mapping(address => uint256) private _balance;

    function deposit() external payable {
        address sender = msg.sender;
        uint256 value = msg.value;
        assembly {
            mstore(0, sender)
            mstore(32, _balance.slot)
            let hash := keccak256(0, 64)
            sstore(hash, value)
        }
    }

    function withdraw() external {
        address sender = msg.sender;
        uint256 toSend;
        bool success;

        assembly {
            mstore(0, sender)
            mstore(32, _balance.slot)
            let hash := keccak256(0, 64)
            toSend := sload(hash)
        }

        require(toSend != 0, "No balance found");

        assembly {
            mstore(0, sender)
            mstore(32, _balance.slot)
            let hash := keccak256(0, 64)
            sstore(hash, 0)
            success := call(2300, sender, toSend, 0, 0, 0, 0x20)
        }

        require(success, "Failed to send Ether");
    }
}
