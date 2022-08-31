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

// DSProxyFactory - 0x6cc22DA903F9426174D77BC311d074BC38137D90
// DSProxy (address1) - 0x040A55A82DC53FF320c2700B584188a9646Af0db
// ProxyAuth - 0x211B6f635934F760528025963f3312f2E80C974A
// DSGuardFactory - 0xF7361F9e6fABaF7acB950fd8A26dB7Ab5A6852af
// RecipeExecutor - 0x750A623c070D0F35c00475670ef3712F59a3e4DB
// Trigger - 0x7319C7179d8a5D2ea1A475610Bb57DB2F2B7B059
// Target - 0xB544b3acD5366d296493589b6F50EDe77057BA25
// Action - 0x27AC1FF08612aA1b0bad81955aA9f1d122aDc7E3
// ActionLiquityOpen - 0x7De2cE03D0A6404794d9A3c7679597D79E0AFC7E
// ActionLiquityPayback - 0x27d95B9Bb17Eb45C269D5d4554433980a60C0A22

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
