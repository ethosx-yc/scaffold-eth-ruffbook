// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";
import "./Test.sol";

contract Action{
    address constant TARGET_ADDRESS = 0xB544b3acD5366d296493589b6F50EDe77057BA25; //Rinkeby
    // address constant TARGET_ADDRESS = 0x05Aa229Aec102f78CE0E852A812a388F076Aa555;
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