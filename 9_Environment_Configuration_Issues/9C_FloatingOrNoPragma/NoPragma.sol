// SPDX-License-Identifier: MIT

//This contract uses no pragma
contract FloatingPragma {
    mapping(address => uint) private balance;

    function deposit() external payable {
        balance[msg.sender] = msg.value;
    }

     function withdraw() external {
        require(balance[msg.sender]!=0,"No balance found");
        uint toSend=balance[msg.sender];
        payable(msg.sender).transfer(toSend);
        balance[msg.sender]=0;
    }
}