// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Script, console} from "forge-std/Script.sol";

contract HelperConfig is Script {
    // helpers
    uint256 constant CONSTANT = 0;

    // chain configurations
    NetworkConfig public activeNetworkConfig;

    function getActiveNetworkConfig() public view returns (NetworkConfig memory) {
        return activeNetworkConfig;
    }

    struct NetworkConfig {
        address initialOwner;
    }

    constructor() {
        if (block.chainid == 8453 || block.chainid == 123) {
            activeNetworkConfig = getMainnetConfig();
        } else if (block.chainid == 84532 || block.chainid == 84531) {
            activeNetworkConfig = getTestnetConfig();
        } else {
            activeNetworkConfig = getAnvilConfig();
        }
    }

    function getTestnetConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({initialOwner: 0x7Bb8be3D9015682d7AC0Ea377dC0c92B0ba152eF});
    }

    function getMainnetConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({initialOwner: 0x7Bb8be3D9015682d7AC0Ea377dC0c92B0ba152eF});
    }

    function getAnvilConfig() public pure returns (NetworkConfig memory) {
        // vm.startBroadcast();
        // vm.stopBroadcast();

        return NetworkConfig({initialOwner: 0x7Bb8be3D9015682d7AC0Ea377dC0c92B0ba152eF});
    }
}
