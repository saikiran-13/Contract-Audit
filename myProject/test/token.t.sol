// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import "forge-std/console.sol";
import {Counter} from "../src/Counter.sol";

interface ITokenBank {
    function bankOwner() external view returns (address);

    function bankBalance() external view returns (uint256);

    function depositTokens(uint256 _amount) external;

    function tokenDetails(address _tokenaddress) external;
}

contract TokenBank is Test {
    ITokenBank public tokenbank;

    function setUp() public {
        tokenbank = ITokenBank(0x3192d648E9F9F7a1938Aad886e367BD68a53B3F0);
    }

    function testOwnerAddress() public {
        console.log(tokenbank.bankOwner());
        vm.prank(0xce4FD76812267BaC745B2B0ab1cC73760F8ACb72);
        assertEq(tokenbank.bankBalance(), 0);
    }

    function testDepositTokens() public {
        vm.prank(0xce4FD76812267BaC745B2B0ab1cC73760F8ACb72);
        tokenbank.tokenDetails(0x41Cb39177A332c6dAEcEE40A5343a77411ca6712);
        tokenbank.depositTokens(10);
    }
}
//In the command line use this command
// forge test --fork-url https://eth-sepolia.g.alchemy.com/v2/KZIqOvR96XR-mfaMzDIVWODmCO8Zjyf9 --match-path test/toke
// n.t.sol -vvvv --gas-report
