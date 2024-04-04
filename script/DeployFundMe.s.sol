// SPDX-// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
      //address public constant priceFeed = 0x694AA1769357215DE4FAC081bf1f309aDC325306;

    function run() external returns (FundMe fundMe){
        HelperConfig helperConfig  =  new HelperConfig();
        address priceFeed = helperConfig.activeNetworkConfig();
        vm.startBroadcast();
        fundMe = new FundMe(priceFeed);

        vm.stopBroadcast();
        //return fundMe;
    }
}
