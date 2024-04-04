// SPDX-// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test{
    FundMe fundMe;
    
    function setUp() external {
        console.log("Setting up FundMeTest");
        DeployFundMe dfm = new DeployFundMe();
        fundMe = dfm.run();
       
    }

    function testMinimumDollarIsFive() public view{
        console.log("test demo");
        assertEq(fundMe.MINIMUM_USD(), 5e18 );
    }

    function testOwnerIsMsgSender() public view{
        assertEq(fundMe.i_owner(), msg.sender);
    }

    function testPriceFeeVersionIsAccurate() public view{
        assertEq(fundMe.getVersion(), 4);
    }

}