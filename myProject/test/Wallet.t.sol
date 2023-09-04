// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Wallet} from "../src/Wallet.sol";
import "forge-std/console.sol";

// Examples of deal and hoax
// deal(address, uint) - Set balance of address
// hoax(address, uint) - deal + prank, Sets up a prank(msg.sender) and set balance

contract WalletTest is Test {
    Wallet public wallet;

    function setUp() public {
        wallet = new Wallet();
    }

    function test_WalletBalance() public {
        //Intially balance will be huge number, so setting contract balance
        deal(address(wallet), 233);
        assertEq(address(wallet).balance, 233);
    }

    function test_depositBalance() public {
        uint bal = address(wallet).balance;
        deal(address(123), 100);
        vm.prank(address(123));
        (bool status, ) = address(wallet).call{value: 100}("");
        assertEq(address(wallet).balance, bal + 100);
        assertTrue(status);

        hoax(address(456), 500);
        (bool ok, ) = address(wallet).call{value: 500}("");
        assertEq(address(wallet).balance, bal + 100 + 500);
        assertTrue(ok);
    }

    // function test_withdrawBalance() public {
    //     uint ownerBalance = address(this).balance;
    //     wallet.withdraw(20);
    //     console.log(address(this).balance, ownerBalance + 20);
    //     // assertEq(address(this).balance, ownerBalance + _amount);
    // }
}
