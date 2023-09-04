// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Error} from "../src/Error.sol";

contract ErrorTest is Test {
    Error public error;

    function setUp() public {
        error = new Error();
    }

    //use testFail to deal with the errors.For specific errors use these

    function testError() public {
        vm.expectRevert();
        error.throwError();
    }

    function testRequireMessageError() public {
        vm.expectRevert(bytes("An Error Occured!!"));
        error.throwError();
    }

    function testAssertionErrors() public {
        assertEq(uint256(10), uint256(10), "Number should be equal to 10");
    }

    function testSimpleCustomError() public {
        vm.expectRevert(Error.simpleError.selector);
        error.simpleCustomError();
    }

    function testCustomMessageError() public {
        vm.expectRevert(abi.encodeWithSelector(Error.customError.selector, "Something went wrong"));
        error.throwCustomError();
    }
}
