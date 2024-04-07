// SPDX-// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract InteractionTest is Test {
    FundMe fundMe;
    address alice = makeAddr("alice");
    address bob = makeAddr("bob");
    uint256 constant SEND_VALUE = 10e18;
    uint256 constant STARTING_BALANCE = 20 ether;

    function setUp() external {
        DeployFundMe deploy = DeployFundMe();
        fundMe = deploy.run();
        vm.deal(alice, STARTING_BALANCE);
        vm.deal(bob, STARTING_BALANCE);
    }


}