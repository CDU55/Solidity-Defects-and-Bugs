// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//The data provided by the caller in the "participate" method is not validated before testing to see if the number is a winning one.
//This could lead to a division by 0.
contract ImproperDataValidation {
    mapping(address => uint256) participants;
    uint256 private _someNumber;
    uint256 private _prize;
    uint256 private _fee;
    bool private _gameEnded;

    constructor(
        uint256 someNumber,
        uint256 prize,
        uint256 fee
    ) payable {
        require(
            msg.value == _prize,
            "Provide currency equal to the declared prize"
        );
        _someNumber = someNumber;
        _prize = prize;
        _fee = fee;
    }

    function participate(uint256 validateMe) external payable {
        require(msg.value == _fee, "Please attach the correct fee");
        require(participants[msg.sender] == 0, "You already participated");
        require(!_gameEnded, "The game has ended");
        if (isWinner(validateMe)) {
            payable(msg.sender).transfer(_prize);
            _gameEnded = true;
        } else {
            participants[msg.sender] = 1;
            modifyState(validateMe);
        }
    }

    function isWinner(uint256 option) private view returns (bool) {
        //Test if the option is a winning one
        return (_someNumber <= option) || (_someNumber / option) == 1;
    }

    function modifyState(uint256 option) private {
        _someNumber = _someNumber / option;
    }
}
