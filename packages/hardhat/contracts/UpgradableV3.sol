// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @custom:oz-upgrades-unsafe-allow external-library-linking
import "./Libs/IterableMapping.sol";

contract UpgradableV3 {
    using IterableMappingUint for IterableMappingUint.Map;
    uint256 private _value;
    mapping(address => uint256) private _amap;
    IterableMappingUint.Map private _amap2;

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

    // Increments the stored value by 1
    function increment() public {
        _value = _value + 1;
        _amap[msg.sender] += 1;
        _amap2.insertAdd(msg.sender, 1);
        emit ValueChanged(_value);
    }

    function amap() public view returns (uint256) {
        return _amap[msg.sender];
    }

    function amap2() public view returns (uint256) {
        return _amap2.get(msg.sender);
    }
}
