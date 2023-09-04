// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "forge-std/console.sol";

contract Error {
    error simpleError();
    error customError(string message);

    function throwError() external pure {
        require(false, "An Error Occured!!");
    }

    function simpleCustomError() external pure {
        revert simpleError();
    }

    function throwCustomError() external pure {
        revert customError("Something went wrong");
    }
}
