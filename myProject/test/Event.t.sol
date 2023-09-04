// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Event} from "../src/Event.sol";

contract EventTest is Test {
    event Transfer(address indexed from, address indexed to, uint256 amount);

    Event public events;

    function setUp() public {
        events = new Event();
    }

    function testEmitEvent() public {
        // function expectEmit(
        //     bool checkTopic1,
        //     bool checkTopic2,
        //     bool checkTopic3,
        //     bool checkData
        // ) external;

        // 1. Tell Foundry which data to check
        vm.expectEmit(true, true, false, true); //check only 1st indexed,2nd indexed and rest
        // 2. Emit the expected event
        emit Transfer(address(this), address(1), 1234);
        // 3. Call the function that should emit the event
        events.transfer(address(this), address(1), 1234);

        //Checks only 1st Parameter
        vm.expectEmit(true, false, false, false);
        emit Transfer(address(this), address(10), 34);
        events.transfer(address(this), address(1), 1234);
    }

    function testEmitManyTransferEvent() public {
        address[] memory to = new address[](2);
        to[0] = address(111);
        to[1] = address(222);

        uint256[] memory amounts = new uint[](2);
        amounts[0] = 1;
        amounts[1] = 2;

        for (uint256 i = 0; i < to.length; i++) {
            // 1. Tell Foundry which data to check
            vm.expectEmit(true, true, false, true);
            // 2. Emit the expected event
            emit Transfer(address(this), to[i], amounts[i]);
        }

        // 3. Call the function that should emit the event
        events.transferMany(address(this), to, amounts);
    }
}
