// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";
import "./Test.sol";

contract Action{
    address constant TARGET_ADDRESS = 0xa513E6E4b8f2a923D98304ec87F64353C4D5C853;
    function executeAction() public payable returns (bytes32) {
        

        (uint256 repayAmount, bytes memory logData) = _setA();
        return bytes32(repayAmount);
    }

    function getTarget() public view returns(address){
        return TARGET_ADDRESS;
    }

    function _setA() internal returns (uint256, bytes memory) {
        console.log("\nAction");
        console.log("Msg Sender:", msg.sender);
        Target(TARGET_ADDRESS).setA();
        console.log("Target A:", Target(TARGET_ADDRESS).getA(msg.sender));

        bytes memory logData = abi.encode(Target(TARGET_ADDRESS).getA(msg.sender));
        return (Target(TARGET_ADDRESS).getA(msg.sender), logData);
    }

}