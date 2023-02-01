// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Use all state variables that are declared or remove the unused ones
contract ShadowingStateConstructorParamFixed {
    uint256 private _sendToLimit;

    constructor(uint256 sendToLimitParam) {
        _sendToLimit = sendToLimitParam;
    }

    function split(address[] calldata sendTo) external payable {
        require(
            msg.value > 0,
            "Please also send the currency that is mean to be split"
        );
        require(
            sendTo.length > 0,
            "Please specify who the currency will be distributed to"
        );
        require(
            sendTo.length <= _sendToLimit,
            "The maximum amount of receivers has been exceded"
        );
        uint256 amount = msg.value / sendTo.length;
        for (uint256 index = 0; index < sendTo.length; index++) {
            bool success = payable(sendTo[index]).send(amount);
            require(success, "Failed to send currency");
        }
    }
}
