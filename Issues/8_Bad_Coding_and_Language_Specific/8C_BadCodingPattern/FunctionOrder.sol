// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract does not have the proper function order.
contract FunctionOrder {
    function somethingPrivate() private {}

    function somethingInternal() internal {}

    function somethingPublic() public {}

    function somethingExternal() external {}

    receive() external payable {}

    constructor() {}
}
