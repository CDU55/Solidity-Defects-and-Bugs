// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract displays an example of block info dependency. I uses the block number to generate a pseudo-random number.
//Since the value that the "random" will have can be determined before, this leaves room for an attacker to exploit the knowledge that he has.
contract BlockInfoDependency {
    uint256 private _contendersCount;
    mapping(uint256 => address) private _contenders;
    address private _owner;

    modifier onlyOwner() {
        require(
            msg.sender == _owner,
            "Only the owner of the contract can access this"
        );
        _;
    }

    constructor() {
        _owner = msg.sender;
        _contendersCount = 0;
    }

    receive() external payable {}

    function register(address contender) external payable {
        require(
            msg.value >= 1 ether && msg.value < 2 ether,
            "Invalid entrance tax"
        );
        _contenders[_contendersCount] = contender;
        _contendersCount = _contendersCount + 1;
    }

    function chooseWinner() external onlyOwner {
        require(_contendersCount > 10, "Not enough contenders registered");
        uint256 winnerIndex = block.number % _contendersCount;
        _contendersCount = 0;
        payable(_contenders[winnerIndex]).transfer(
            address(this).balance - 1 ether
        );
        payable(_owner).transfer(1 ether);
    }
}
