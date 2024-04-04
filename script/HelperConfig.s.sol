// SPDX-// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregattor.sol";

contract HelperConfig is Script {
    NetworkCofig public activeNetworkConfig;
    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;

    struct NetworkCofig {
        address priceFeed;
    }

    constructor() {
        if (block.chainid == 11155111) {
            activeNetworkConfig = getSepoliaETHConfig();
        } else {
            activeNetworkConfig = getAnvilETHConfig();
        }
    }

    function getSepoliaETHConfig() public pure returns (NetworkCofig memory) {
        NetworkCofig memory sepoliaConfig = NetworkCofig({priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306});

        return sepoliaConfig;
    }

    function getAnvilETHConfig() public returns (NetworkCofig memory) {
        vm.startBroadcast();
        MockV3Aggregator mock = new MockV3Aggregator(DECIMALS, INITIAL_PRICE);
        vm.stopBroadcast();
        NetworkCofig memory anvilConfig = NetworkCofig({priceFeed: address(mock)});
        return anvilConfig;
    }
}
