// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Upgradable {
    uint256 private _value;
 
    // Emitted when the stored value changes
    event ValueChanged(uint256 newValue);
 
    // Stores a new value in the contract
    function store(uint256 newValue) public {
        _value = newValue;
        emit ValueChanged(newValue);
    }
 
    // Reads the last stored value
    function retrieve() public view returns (uint256) {
        return _value;
    }
}