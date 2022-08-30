// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "./interfaces/IDSProxy.sol";
import "./ProxyPermission.sol";
import "hardhat/console.sol";

// import "../auth/ProxyPermission.sol";
// import "../actions/ActionBase.sol";
// import "../core/DFSRegistry.sol";
// import "./strategy/StrategyModel.sol";
// import "./strategy/StrategyStorage.sol";
// import "./strategy/BundleStorage.sol";
// import "./strategy/SubStorage.sol";
// import "../interfaces/flashloan/IFlashLoanBase.sol";
// import "../interfaces/ITrigger.sol";

/// @title Entry point into executing recipes/checking triggers directly and as part of a strategy
contract RecipeExecutor is ProxyPermission {
    error TriggerNotActiveError(uint256);

    function executeRecipe(address actionAddress) public payable {
        _executeAction(actionAddress);
    }

    function _executeAction(address actionAddr)
        internal
        returns (bytes32 response)
    {
        console.log("\nRecipeExecutor");
        console.log("Msg Sender: ", msg.sender);
        console.log("This address: ", address(this));
        response = IDSProxy(address(this)).execute(
            actionAddr,
            abi.encodeWithSignature("executeAction()")
        );
    }
}
