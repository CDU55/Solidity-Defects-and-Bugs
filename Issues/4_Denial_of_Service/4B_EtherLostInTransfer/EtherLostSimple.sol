// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//If the caller sends Ether to an "orphan" address, that Ether is lost forever
contract EtherLostSimple {
    event Forwarded(address, address);
    function forward(address recipient) external payable {
        require(msg.value > 0);
        require(recipient != address(0));
        emit Forwarded(msg.sender, recipient);
        payable(recipient).transfer(msg.value);
    }
}
