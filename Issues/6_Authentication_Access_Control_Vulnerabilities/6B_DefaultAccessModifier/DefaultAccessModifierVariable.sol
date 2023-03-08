// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

// The default modifier is `public`, unlike in common programming languages.
// So, information that is supposed to be private becomes modifiable from outside the contract (e.g., inherited contracts)
contract DefaultAccessModifierVariable {
    address owner;
    bool prizeClaimed;
    uint256 secretNumber;
    uint256 fee;

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only the owner of the contract can access this"
        );
        _;
    }

    modifier notOwner() {
        require(
            msg.sender != owner,
            "Only the owner of the contract can access this"
        );
        _;
    }

    constructor(uint256 _secretNumber, uint256 gamefee) payable {
        require(msg.value > gamefee * 2, "Must fund the initial prize pool");
        owner = msg.sender;
        secretNumber = _secretNumber;
        fee = gamefee;
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
        if (secretNumber == option) {
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

    function resetNumber(uint256 number) external payable onlyOwner {
        require(
            msg.value > fee * 2,
            "Resseting the number must also replenish the prize fund"
        );
        secretNumber = number;
        prizeClaimed = false;
    }
}
