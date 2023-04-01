// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Check that the recipients count is not zero
contract PossibleDivisionByZeroFixed {
    uint256 public recipientsCount;
    mapping(uint256 => address payable) private _recipients;
    mapping(address => bool) private _rewardCollected;

    address owner;

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only the owner of the contract can access this"
        );
        _;
    }

    constructor() {
        owner = msg.sender;
        recipientsCount = 0;
    }

    receive() external payable {}

    function registerRecipient(address payable recipient) external {
        recipientsCount = recipientsCount + 1;
        _recipients[recipientsCount] = recipient;
    }

    function distributeToRecipients() external onlyOwner {
        require(recipientsCount > 0);
        uint256 share = address(this).balance / recipientsCount;
        for (uint256 index = 1; index <= recipientsCount; index++) {
            if (_rewardCollected[_recipients[index]]) {
                continue;
            }

            if (_recipients[index].send(share)) {
                _rewardCollected[_recipients[index]] = true;
            }
        }
    }
}
