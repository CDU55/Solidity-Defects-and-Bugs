// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract contains a divison operation where the divisor is not zero-checked.
//If there are no recipients provided, the method will fail.
contract PossibleDivisionByZeroArrayLength {
    function split(address[] calldata recipients) external payable {
        require(
            msg.value > 0,
            "Please provide currency to be split among recipients"
        );
        uint256 bounty = msg.value / recipients.length;
        for (uint256 index = 0; index < recipients.length; index++) {
            (bool success, ) = payable(recipients[index]).call{value: bounty}(
                ""
            );
            require(success, "Could not send ether to recipients");
        }
    }
}
