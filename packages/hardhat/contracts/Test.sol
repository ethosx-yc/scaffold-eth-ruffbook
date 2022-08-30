// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Import this file to use console.log
import "hardhat/console.sol";
import "./ProxyAuth.sol";
import "./interfaces/IDSProxy.sol";

contract Target {
    mapping(address => uint256) _a;
    address[] _addresses;

    function setA() public {
        console.log("Target: Msg from", msg.sender);
        _a[msg.sender] += 1;
        _addresses.push(msg.sender);
    }

    function getA(address addr_) public view returns (uint256) {
        return _a[addr_];
    }

    function addresses() public view returns (address[] memory) {
        return _addresses;
    }
}

contract Trigger {
    // Target private _target;

    // constructor(address target_) {
    //     _target = Target(target_);
    // }

    // function trigger(address executor_address_) public {
    //     bytes memory actionPayload = abi.encodeWithSignature("setA()");
    //     IDSProxy(executor_address_).execute(address(_target), actionPayload);
    //     bytes memory executePayload = abi.encodeWithSignature(
    //         "execute(address,bytes)",
    //         address(_target),
    //         actionPayload
    //     );
    //     (bool success, bytes memory returnData) = address(executor_address_)
    //         .call(executePayload);
    //     console.log("Success", success);
    //     require(
    //         success,
    //         "low-level call of function execute failed [transfer(address,address,uint256), param1, param2, param3]"
    //     );
    // }

    function executeStrategy(
        address userProxy,
        address proxyAuthAddress,
        address recipeExecutorAddress,
        address actionAddress
    ) public {
        // check bot auth

        // execute actions
        callActions(
            userProxy,
            proxyAuthAddress,
            recipeExecutorAddress,
            actionAddress
        );
    }

    function callActions(
        address userProxy,
        address proxyAuthAddress,
        address recipeExecutorAddress,
        address actionAddress
    ) internal {
        ProxyAuth(proxyAuthAddress).callExecute{value: msg.value}(
            userProxy,
            recipeExecutorAddress,
            abi.encodeWithSignature(
                "executeRecipe(address)",
                address(actionAddress)
            )
        );
    }
}
