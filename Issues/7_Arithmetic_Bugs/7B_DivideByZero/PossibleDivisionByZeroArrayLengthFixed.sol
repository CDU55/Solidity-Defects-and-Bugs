// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Check that the array of recipients is not empty
contract PossibleDivisionByZeroArrayLengthFixed {
    function split(address[] calldata recipients) external payable {
        require(recipients.length > 1, "Please provide 2 or more recipients");
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
