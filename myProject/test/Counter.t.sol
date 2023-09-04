// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import "forge-std/console.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;
    address fakeOwner = address(1234);

    function setUp() public {
        //beforeEach
        counter = new Counter();
        // counter.setNumber(0);
    }

    //msg.sender = address(this)
    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
        assertGe(counter.number(), 0);
        // assertNotEq(counter.number(), 2000);
    }

    function testFuzz_setNumberByAssume(uint256 x) public {
        //It takes the range from 1 to 20
        x = bound(x, 1, 20);
        assertLe(x, 20);
        vm.assume(x != 10);
        //skips the case x == 10
        counter.setNumber(x);
        assertEq(counter.number(), x);
        assertNotEq(counter.number(), 10);
    }

    function testFail_Decrement() public {
        //underflow before decrement number=0
        counter.decrement();
        console.log("Number", counter.number());
        assertEq(counter.number(), 0);
    }

    function test_Decrement() public {
        vm.prank(address(1)); //msg.sender changes from address(this) to address(1)
        vm.expectRevert(); //Expecting undeflow
        counter.decrement();
    }

    function test_IncDec() public {
        counter.increment();
        counter.increment();
        counter.decrement();
        assertEq(counter.number(), 1);
    }

    function testFail_SetOwner() public {
        // msg.sender = address(this)
        counter.setOwner(address(1));
        //msg.sender = fakeOwner
        vm.startPrank(fakeOwner);
        counter.setOwner(address(2));
        counter.setOwner(address(4));
        vm.stopPrank();
        //only owner can set the newaddress so this will fail
        counter.setOwner(address(123456));
        //msg.sender = address(this)
    }

    function testFuzz_SetOwner(address _newOwner) public {
        counter.setOwner(_newOwner);
        console.log(address(this), _newOwner);
        assertEq(counter.owner(), _newOwner, "Owner not updated");
    }
}
