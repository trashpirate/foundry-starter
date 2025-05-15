// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Script} from "forge-std/Script.sol";
import {Contract} from "src/Contract.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {Upgrades} from "@openzeppelin/foundry-upgrades/Upgrades.sol";

contract Deploy is Script {
    function run() external returns (Contract, HelperConfig) {
        HelperConfig config = new HelperConfig();

        (address initialOwner) = config.activeNetworkConfig();

        vm.startBroadcast();

        // Deploy a UUPS proxy:
        address proxy = Upgrades.deployUUPSProxy("Contract.sol", abi.encodeCall(Contract.initialize, (initialOwner)));

        // Deploy a transparent proxy:
        // address proxy = Upgrades.deployTransparentProxy(
        //     "Contract.sol",
        //     INITIAL_OWNER_ADDRESS_FOR_PROXY_ADMIN,
        //     abi.encodeCall(Contract.initialize, (initialOwner))
        // );

        // Deploy an upgradeable beacon and a beacon proxy:
        // address beacon = Upgrades.deployBeacon(Contract.sol", INITIAL_OWNER_ADDRESS_FOR_BEACON);

        // address proxy = Upgrades.deployBeaconProxy(
        //     beacon, abi.encodeCall(Contract.initialize, (initialOwner))
        // );

        Contract myContract = Contract(proxy);

        vm.stopBroadcast();
        return (myContract, config);
    }
}
