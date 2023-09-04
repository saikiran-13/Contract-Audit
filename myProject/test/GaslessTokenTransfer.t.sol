// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {GaslessTokenTransfer} from "../src/Gaslesstoken.sol";
import {ERC20Permit} from "../src/App/ERC20Permit.sol";

contract GaslessTokenTransferTest is Test {
    GaslessTokenTransfer private gaslesstransfer;
    ERC20Permit private token;
    uint constant SENDER_PRIVATE_KEY = 1258;
    address sender;
    address receiver;
    uint AMOUNT = 500;
    uint FEE = 10;

    function setUp() public {
        sender = vm.addr(SENDER_PRIVATE_KEY);
        receiver = address(456);
        token = new ERC20Permit("TestToken", "TST", 18);
        gaslesstransfer = new GaslessTokenTransfer();
        token.mint(sender, AMOUNT + FEE);
    }

    function testValidSign() public {
        uint deadline = block.timestamp + 60;
        bytes32 permitHash = _getMessageHash(
            sender,
            address(gaslesstransfer),
            AMOUNT + FEE,
            token.nonces(sender),
            deadline
        );

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            SENDER_PRIVATE_KEY,
            permitHash
        );
        gaslesstransfer.send(
            address(token),
            sender,
            receiver,
            AMOUNT,
            FEE,
            deadline,
            v,
            r,
            s
        );

        assertEq(token.balanceOf(sender), 0, "Sender Balance");
        assertEq(token.balanceOf(receiver), AMOUNT, "Receiver Balance");
        assertEq(token.balanceOf(address(this)), FEE, "Fees");
    }

    function _getMessageHash(
        address owner,
        address spender,
        uint value,
        uint nonce,
        uint deadline
    ) private view returns (bytes32) {
        return
            keccak256(
                abi.encodePacked(
                    "\x19\x01",
                    token.DOMAIN_SEPARATOR(),
                    keccak256(
                        abi.encode(
                            keccak256(
                                "Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"
                            ),
                            owner,
                            spender,
                            value,
                            nonce,
                            deadline
                        )
                    )
                )
            );
    }
}
