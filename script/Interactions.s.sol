// SPXD-// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;
    function fundFundMe(address mostRecentAddress) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentAddress)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("fundme => %s", SEND_VALUE);

    }

    function run() external {
        address mostRecentlyDeploy = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
         vm.startBroadcast();
        fundFundMe(mostRecentlyDeploy);
        vm.stopBroadcast();
    }
}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address mostRecentAddress) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentAddress)).withdraw();
        vm.stopBroadcast();
        console.log("withdraw");
    }

    function run() external {
        address mostRecentlyDeploy = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);  
        withdrawFundMe(mostRecentlyDeploy);
       
    }

}
