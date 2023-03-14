// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//The "Split" method declares a local variable with the same name as one of the parameters.
contract ShadowingParameterVariable {
    function split(address[] calldata sendTo, uint256 amountToSend)
        external
        payable
    {
        require(
            msg.value > 0,
            "Please also send the currency that is meant to be split"
        );
        require(
            sendTo.length > 0,
            "Please specify who the currency will be distributed to"
        );
        require(
            amountToSend * sendTo.length <= msg.value,
            "Please specify the correct ammount"
        );
        uint256 amountToSend = msg.value / sendTo.length;
        for (uint256 index = 0; index < sendTo.length; index++) {
            bool success = payable(sendTo[index]).send(amountToSend);
            require(success, "Failed to send currency");
        }
    }
}
