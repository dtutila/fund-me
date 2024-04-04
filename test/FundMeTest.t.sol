// SPDX-// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;
    address alice = makeAddr("alice");
    address bob = makeAddr("bob");
    uint256 constant SEND_VALUE = 10e18;
    uint256 constant STARTING_BALANCE = 20 ether;


    modifier funded() {
        vm.prank(alice);
        fundMe.fund{value: SEND_VALUE}();
        _;
    }

    function setUp() external {
        console.log("Setting up FundMeTest");
        DeployFundMe dfm = new DeployFundMe();
        fundMe = dfm.run();
        vm.deal(alice, STARTING_BALANCE);
        vm.deal(bob, STARTING_BALANCE);
    }

    function testMinimumDollarIsFive() public view {
        console.log("test demo");
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public view {
        assertEq(fundMe.getOwner(), msg.sender);
    }

    function testPriceFeeVersionIsAccurate() public view {
        assertEq(fundMe.getVersion(), 4);
    }

    function testNotEnoughtETH() public {
        vm.expectRevert();
        fundMe.fund();
    }

  

    function testDundUpdatesDoundedDataStructure() public funded{
        

        uint256 amountFunded = fundMe.getAddressToAmountFounded(alice);

        assertEq(amountFunded, SEND_VALUE);
    }

    function testAddsFunderToArrayOfFunders() public funded {
        address funder = fundMe.getFunder(0);

        assertEq (alice, funder);

    }

    function testOnlyOwnerCanWithdraw() public funded {
        vm.prank(alice);
        vm.expectRevert();
        fundMe.withdraw();
    }

    function testWithdrawWithASingleOwner() public funded {
        uint256 initialOwnerBalance = fundMe.getOwner().balance;
        uint256 initialFundMeBalance = address(fundMe).balance;

        vm.prank(fundMe.getOwner());
        fundMe.withdraw();

        uint256 finalOwnerBalance = fundMe.getOwner().balance;
        uint256 finalFundMeBalance = address(fundMe).balance;

        assertEq(finalFundMeBalance, 0);
        assertEq(initialOwnerBalance + initialFundMeBalance, finalOwnerBalance);

    }

    function testWithdrawWithMultipleOwners() public funded {
        uint160 numberOfFunders = 10;
        uint160 initialIndex = 1;

        for (uint160 i = initialIndex; i < numberOfFunders; i++) {
            hoax(address(i), SEND_VALUE);
            fundMe.fund{value: SEND_VALUE}();
        }
        
        uint256 initialOwnerBalance = fundMe.getOwner().balance;
        uint256 initialFundMeBalance = address(fundMe).balance;

        vm.prank(fundMe.getOwner());
        fundMe.withdraw();
        vm.stopPrank();

        uint256 finalOwnerBalance = fundMe.getOwner().balance;
        uint256 finalFundMeBalance = address(fundMe).balance;

        assertEq(finalFundMeBalance, 0);
        assertEq(initialOwnerBalance + initialFundMeBalance, finalOwnerBalance);

    }


}
