// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: set the balance of the current use equal to 0 before the transfer
contract ReentrancyDAOFixed {
    mapping(address => uint256) private _balance;

    function deposit() external payable {
        _balance[msg.sender] = msg.value;
    }

    function withdraw() external {
        uint256 toSend = _balance[msg.sender];
        require(_balance[msg.sender] != 0, "No balance found");
        _balance[msg.sender] = 0;
        (bool sent, ) = payable(msg.sender).call{value: toSend}("");
        require(sent, "Failed to send Ether");
    }
}
