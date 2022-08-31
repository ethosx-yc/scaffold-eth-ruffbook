// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";
import "./interfaces/IBorrowerOperations.sol";
import "./utils/TokenUtils.sol";

contract ActionLiquityOpen {
    using TokenUtils for address;

    IBorrowerOperations constant BorrowerOperations =
        IBorrowerOperations(0x91656701b33eca6425A239930FccAA842D0E2031);

    address constant LUSD_TOKEN_ADDRESS =
        0x9C5AE6852622ddE455B6Fca4C1551FC0352531a3;

    struct Params {
        uint256 maxFeePercentage; // Highest borrowing fee to accept, ranges between 0.5 and 5%
        uint256 collAmount; // Amount of WETH tokens to supply as collateral
        uint256 lusdAmount; // Amount of LUSD tokens to borrow from the trove, protocol minimum net debt is 1800
        address from; // Address where to pull the collateral from
        address to; // Address that will receive the borrowed tokens
        address upperHint;
        address lowerHint;
    }

    function executeAction() public payable returns (bytes32) {
        Params memory params;
        params.maxFeePercentage = (1e18 / 1000) * 7;
        params.collAmount = 3 ether;
        params.lusdAmount = 2100 ether;
        params.from = address(this);
        params.to = address(this);

        (uint256 collSupplied, bytes memory logData) = _liquityOpen(params);

        return bytes32(collSupplied);
    }

    function _liquityOpen(Params memory _params)
        internal
        returns (uint256, bytes memory)
    {
        // if (_params.collAmount == type(uint256).max) {
        //     _params.collAmount = TokenUtils.WETH_ADDR.getBalance(_params.from);
        // }
        // TokenUtils.WETH_ADDR.pullTokensIfNeeded(
        //     _params.from,
        //     _params.collAmount
        // );
        // TokenUtils.withdrawWeth(_params.collAmount);

        BorrowerOperations.openTrove{value: _params.collAmount}(
            _params.maxFeePercentage,
            _params.lusdAmount,
            _params.upperHint,
            _params.lowerHint
        );

        LUSD_TOKEN_ADDRESS.withdrawTokens(_params.to, _params.lusdAmount);

        bytes memory logData = abi.encode(
            _params.maxFeePercentage,
            _params.collAmount,
            _params.lusdAmount,
            _params.from,
            _params.to
        );
        return (_params.collAmount, logData);
    }
}
