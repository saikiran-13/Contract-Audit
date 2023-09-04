// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import "forge-std/console.sol";
import {MyToken} from "../src/MyToken.sol";

//Cheatcodes allow you to change the block number, your identity, and more. They are invoked by calling specific functions on a specially designated address:
//use vm just before the function execution if u want to continue it for sequence of transacations usevm.startPrank(owner); vm.stopPrank();

contract MyTokenTest is Test {
    MyToken public myToken;
    address owner = address(0);
    address sender = address(1234);
    address destination = address(456);

    function setUp() public {
        myToken = new MyToken();
    }

    //Use test to identiy it as test case to be passed
    function testMintFn() public {
        // assertEq(address(myToken).balance, 0);
        myToken.mint(destination, 10000);
        console.log("After Mint", address(myToken).balance);
        // assertEq(address(myToken).balance, 10 ether);
    }

    //use testFail to identify as test case to be failed
    function testFailMintFn() public {
        //setting the owner address to the zeroth address
        vm.prank(owner);
        myToken.mint(destination, 10e18);
        console.log("After Mint", address(myToken).balance);
    }
}
