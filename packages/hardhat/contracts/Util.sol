// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.5.17;

// Import this file to use console.log
import "hardhat/console.sol";

contract Util {
    event ada(bytes32 b_);

    function a() public returns(bytes4){
        emit ada(bytes32(bytes4(keccak256("execute(address,bytes)"))));
        return bytes4(keccak256("execute(address,bytes)"));
    }
}