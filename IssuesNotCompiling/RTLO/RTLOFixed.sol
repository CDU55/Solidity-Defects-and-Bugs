// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract RTLO{

    address private owner;
    uint private _firstPrize;
    uint private _secondPrize;

      modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner of the contract can access this");
        _;
    }

    constructor(uint firstPrize,uint secondPrize)
    {
        _firstPrize=firstPrize;
        _secondPrize=secondPrize;
    }

    function declareWinners(address f, address s) external onlyOwner
    {
        sendPrizes(
            f,s
        );
    }
    
    function sendPrizes(address f , address s) private
    {
        payable(f).transfer(_firstPrize);
        payable(s).transfer(_secondPrize);
    }
}