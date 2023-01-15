// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Check the payload size
contract ShortAddressFixed {
    mapping(address => uint) private _balance;

     modifier checkPayloadSize(uint size) {
        require(msg.data.length >= size + 4,"Payload too small for method signature");
        _;
     }

    function deposit() external payable {
        _balance[msg.sender] = msg.value;
    }

     function withdraw() external {
        require(_balance[msg.sender]!=0,"No balance found");
        uint toSend=_balance[msg.sender];
        payable(msg.sender).transfer(toSend);
        _balance[msg.sender]=0;
    }

    function transfer(address to, uint256 value) checkPayloadSize(2 * 32) external {
        require(_balance[msg.sender]>=value,"Your balance is smaller than the transfer value");
        payable(to).transfer(value);
    }   
}