// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract contains a private variable that is initialized with a constand value.
//Since it is a private variable, its value is not meant to be known to external sources, but the value can be deduced by reviewing the code of the contract.
contract ImproperPrivateVariableInitialization {
    address private _owner;
    bool public prizeClaimed;
    bytes32 private _secretNumber;
    uint256 public fee;

    modifier onlyOwner() {
        require(
            msg.sender == _owner,
            "Only the owner of the contract can access this"
        );
        _;
    }

    modifier notOwner() {
        require(
            msg.sender != _owner,
            "Only the owner of the contract can access this"
        );
        _;
    }

    constructor(uint256 secretNumberParam, uint256 feeParam) payable {
        require(msg.value > feeParam * 2, "Must fund the initial prize pool");
        require(secretNumberParam > 0, "Option should be between 1 and 10");
        require(secretNumberParam <= 10, "Option should be between 1 and 10");
        _owner = msg.sender;
        fee = feeParam;
        _secretNumber = keccak256(abi.encodePacked(secretNumberParam));
    }

    receive() external payable {}

    function guessTheNumber(uint256 option) external payable notOwner {
        require(msg.value == fee, "You must");
        require(option > 0, "Option should be between 1 and 10");
        require(option <= 10, "Option should be between 1 and 10");
        require(
            !prizeClaimed,
            "The prize has already been claimed, plese wait for the secret number reset"
        );
        bytes32 optionhash = keccak256(abi.encodePacked(option));
        if (_secretNumber == optionhash) {
            require(
                address(this).balance > fee * 2,
                "Insuficient funds to receive prize"
            );
            prizeClaimed = true;
            payable(msg.sender).transfer(msg.value * 2);
        }
    }

    function retrieveEarnings() external payable onlyOwner {
        require(prizeClaimed, "The prize has not yet been claimed");
        payable(msg.sender).transfer(address(this).balance);
    }
}
