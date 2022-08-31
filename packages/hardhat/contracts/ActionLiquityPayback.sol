// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "hardhat/console.sol";
import "./interfaces/IBorrowerOperations.sol";
import "./utils/TokenUtils.sol";

contract ActionLiquityPayback {
    using TokenUtils for address;

    IBorrowerOperations constant BorrowerOperations =
        IBorrowerOperations(0x91656701b33eca6425A239930FccAA842D0E2031);

    address constant LUSD_TOKEN_ADDRESS =
        0x9C5AE6852622ddE455B6Fca4C1551FC0352531a3;

    struct Params {
        uint256 lusdAmount; // Amount of LUSD tokens to repay
        address from; // Address where to pull the tokens from
        address upperHint;
        address lowerHint;
    }

    function executeAction() public payable virtual returns (bytes32) {
        Params memory params;

        params.lusdAmount = 100 ether;
        params.from = address(this);

        (uint256 repayAmount, bytes memory logData) = _liquityPayback(params);
        return bytes32(repayAmount);
    }

    //////////////////////////// ACTION LOGIC ////////////////////////////

    /// @notice Repays LUSD tokens to the trove
    function _liquityPayback(Params memory _params)
        internal
        returns (uint256, bytes memory)
    {
        LUSD_TOKEN_ADDRESS.pullTokensIfNeeded(_params.from, _params.lusdAmount);

        BorrowerOperations.repayLUSD(
            _params.lusdAmount,
            _params.upperHint,
            _params.lowerHint
        );

        bytes memory logData = abi.encode(_params.lusdAmount, _params.from);
        return (_params.lusdAmount, logData);
    }
}
