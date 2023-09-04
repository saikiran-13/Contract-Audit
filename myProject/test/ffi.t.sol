// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import "forge-std/console.sol";

contract FFITest is Test {
    function testFFI() public {
        string[] memory commands = new string[](1);
        commands[0] = "command1";
        // commands[1] = "foundry.txt";
        bytes memory data = vm.ffi(commands);
        console.log(string(data));
    }
}

//foreign function interface using which u can run program and commands in the terminal

// forge test --match-path test/ffi.t.sol --ffi -vvv
