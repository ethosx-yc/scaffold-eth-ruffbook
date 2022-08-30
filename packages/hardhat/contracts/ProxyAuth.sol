// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./interfaces/IDSProxy.sol";
import "hardhat/console.sol";

/// @title ProxyAuth Gets DSProxy auth from users and is callable by the Executor
contract ProxyAuth {
    function callExecute(
        address _proxyAddr,
        address _contractAddr,
        bytes memory _callData
    ) public payable {
        console.log("\nProxy Auth:");
        console.log("Msg Sender", msg.sender);
        IDSProxy(_proxyAddr).execute{value: msg.value}(
            _contractAddr,
            _callData
        );
    }
}
