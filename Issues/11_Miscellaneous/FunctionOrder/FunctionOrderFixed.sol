// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Use the proper function order:  constructor -> fallback -> external -> external_const -> public -> public_const -> internal -> private
contract FunctionOrder {
    constructor() {}

    receive() external payable {}

    function somethingExternal() external {}

    function somethingPublic() public {}

    function somethingInternal() internal {}

    function somethingPrivate() private {}
}
