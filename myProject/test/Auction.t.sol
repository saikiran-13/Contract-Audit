// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import "forge-std/console.sol";
import {Auction} from "../src/Time.sol";

contract AuctionTest is Test {
    //vm.warp,vm.roll,skip,rewind
    // vm.warp - set block.timestamp to future timestamp
    // vm.roll - set block.number
    // skip - increment current timestamp
    // rewind - decrement current timestamp
    Auction public auction;
    uint private startTime = 0;

    function setUp() public {
        auction = new Auction();
    }

    function test_startAuctionBidFails() public {
        vm.expectRevert();
        auction.startAuction();
    }

    function test_startAuctionByWarp() public {
        vm.warp(block.timestamp + 1 days);
        auction.startAuction();
    }

    function test_EndAuctionBidFails() public {
        vm.expectRevert(bytes("Cannot bid"));
        auction.EndAuction();
    }

    function test_IncAndDecTimestamp() public {
        uint t = block.timestamp;
        skip(100); //Increase timestamp by 100sec

        assertEq(block.timestamp, t + 100);
        rewind(10); //Decrease Timestamp bu 10sec
        assertEq(block.timestamp, t + 100 - 10);
    }

    function test_BlockNumber() public {
        vm.roll(1234);
        assertEq(block.number, 1234);
    }
}
