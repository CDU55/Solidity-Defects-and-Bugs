// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Provide a reason for revert
contract ReasonStringRevertFixed {
    mapping(address => uint256) private _balance;

    function deposit(uint256 amount) external payable {
        if (msg.value != amount) {
            revert("Incorrect amount");
        }
        _balance[msg.sender] = amount;
    }

    //Obs: slither reentracy false positive
    function withdraw() external {
        uint256 toSend = _balance[msg.sender];
        if (_balance[msg.sender] == 0) {
            revert("No balance found");
        }
        _balance[msg.sender] = 0;
        bool sent = payable(msg.sender).send(toSend);
        if (!sent) {
            revert("Failed to send Ether");
        }
    }
}
