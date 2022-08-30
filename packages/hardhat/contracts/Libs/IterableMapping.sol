//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library IterableMappingUint {
    struct Map {
        mapping(address => IndexValue) data;
        KeyFlag[] keys;
        uint256 size;
    }
    struct IndexValue {
        uint256 keyIndex;
        uint256 value;
    }
    struct KeyFlag {
        address key;
        bool deleted;
    }

    function insert(
        Map storage self,
        address key,
        uint256 value
    ) public returns (bool replaced) {
        uint256 keyIndex = self.data[key].keyIndex;
        self.data[key].value = value;
        if (keyIndex > 0) return true;
        else {
            keyIndex = self.keys.length + 1;
            self.data[key].keyIndex = keyIndex;
            self.keys.push(KeyFlag(key, false));
            self.size++;
            return false;
        }
    }

    function insertAdd(
        Map storage self,
        address key,
        uint256 value
    ) public returns (bool replaced) {
        uint256 keyIndex = self.data[key].keyIndex;
        self.data[key].value += value;
        if (keyIndex > 0) return true;
        else {
            keyIndex = self.keys.length + 1;
            self.data[key].keyIndex = keyIndex;
            self.keys.push(KeyFlag(key, false));
            self.size++;
            return false;
        }
    }

    function insertSub(
        Map storage self,
        address key,
        uint256 value
    ) public returns (bool replaced) {
        uint256 keyIndex = self.data[key].keyIndex;
        self.data[key].value -= value;
        if (keyIndex > 0) return true;
        else {
            keyIndex = self.keys.length + 1;
            self.data[key].keyIndex = keyIndex;
            self.keys.push(KeyFlag(key, false));
            self.size++;
            return false;
        }
    }

    function remove(Map storage self, address key)
        public
        returns (bool success)
    {
        uint256 keyIndex = self.data[key].keyIndex;
        if (keyIndex == 0) return false;
        delete self.data[key];
        self.keys[keyIndex - 1].deleted = true;
        self.size--;
        return true;
    }

    function get(Map storage self, address key)
        public
        view
        returns (uint256 value)
    {
        return self.data[key].value;
    }

    function contains(Map storage self, address key)
        public
        view
        returns (bool)
    {
        return self.data[key].keyIndex > 0;
    }

    function iterate_start(Map storage self)
        public
        view
        returns (uint256 keyIndex)
    {
        return iterate_next(self, type(uint256).max);
    }

    function iterate_valid(Map storage self, uint256 keyIndex)
        public
        view
        returns (bool)
    {
        return keyIndex < self.keys.length;
    }

    function iterate_next(Map storage self, uint256 keyIndex)
        public
        view
        returns (uint256 r_keyIndex)
    {
        unchecked {
            keyIndex++;
            while (keyIndex < self.keys.length && self.keys[keyIndex].deleted)
                keyIndex++;
        }
        return keyIndex;
    }

    function iterate_get(Map storage self, uint256 keyIndex)
        public
        view
        returns (address key, uint256 value)
    {
        key = self.keys[keyIndex].key;
        value = self.data[key].value;
    }
}

library IterableMappingInt {
    struct Map {
        mapping(address => IndexValue) data;
        KeyFlag[] keys;
        uint256 size;
    }
    struct IndexValue {
        uint256 keyIndex;
        int256 value;
    }
    struct KeyFlag {
        address key;
        bool deleted;
    }

    function insert(
        Map storage self,
        address key,
        int256 value
    ) public returns (bool replaced) {
        uint256 keyIndex = self.data[key].keyIndex;
        self.data[key].value = value;
        if (keyIndex > 0) return true;
        else {
            keyIndex = self.keys.length + 1;
            self.data[key].keyIndex = keyIndex;
            self.keys.push(KeyFlag(key, false));
            self.size++;
            return false;
        }
    }

    function insertAdd(
        Map storage self,
        address key,
        int256 value
    ) public returns (bool replaced) {
        uint256 keyIndex = self.data[key].keyIndex;
        self.data[key].value += value;
        if (keyIndex > 0) return true;
        else {
            keyIndex = self.keys.length + 1;
            self.data[key].keyIndex = keyIndex;
            self.keys.push(KeyFlag(key, false));
            self.size++;
            return false;
        }
    }

    function insertSub(
        Map storage self,
        address key,
        int256 value
    ) public returns (bool replaced) {
        uint256 keyIndex = self.data[key].keyIndex;
        self.data[key].value -= value;
        if (keyIndex > 0) return true;
        else {
            keyIndex = self.keys.length + 1;
            self.data[key].keyIndex = keyIndex;
            self.keys.push(KeyFlag(key, false));
            self.size++;
            return false;
        }
    }

    function remove(Map storage self, address key)
        public
        returns (bool success)
    {
        uint256 keyIndex = self.data[key].keyIndex;
        if (keyIndex == 0) return false;
        delete self.data[key];
        self.keys[keyIndex - 1].deleted = true;
        self.size--;
        return true;
    }

    function get(Map storage self, address key)
        public
        view
        returns (int256 value)
    {
        return self.data[key].value;
    }

    function contains(Map storage self, address key)
        public
        view
        returns (bool)
    {
        return self.data[key].keyIndex > 0;
    }

    function iterate_start(Map storage self)
        public
        view
        returns (uint256 keyIndex)
    {
        return iterate_next(self, type(uint256).max);
    }

    function iterate_valid(Map storage self, uint256 keyIndex)
        public
        view
        returns (bool)
    {
        return keyIndex < self.keys.length;
    }

    function iterate_next(Map storage self, uint256 keyIndex)
        public
        view
        returns (uint256 r_keyIndex)
    {
        unchecked {
            keyIndex++;
            while (keyIndex < self.keys.length && self.keys[keyIndex].deleted)
                keyIndex++;
        }
        return keyIndex;
    }

    function iterate_get(Map storage self, uint256 keyIndex)
        public
        view
        returns (address key, int256 value)
    {
        key = self.keys[keyIndex].key;
        value = self.data[key].value;
    }
}

contract User {
    using IterableMappingUint for IterableMappingUint.Map;
    // Just a struct holding our data.
    IterableMappingUint.Map public data;

    // Insert something
    function insert(address k, uint256 v) external returns (uint256 size) {
        // Actually calls itmap_impl.insert, auto-supplying the first parameter for us.
        data.insert(k, v);
        // We can still access members of the struct - but we should take care not to mess with them.
        return data.size;
    }

    function insertAdd(address k, uint256 v) external returns (uint256 size) {
        // Actually calls itmap_impl.insert, auto-supplying the first parameter for us.
        data.insertAdd(k, v);
        // We can still access members of the struct - but we should take care not to mess with them.
        return data.size;
    }

    function insertSub(address k, uint256 v) external returns (uint256 size) {
        // Actually calls itmap_impl.insert, auto-supplying the first parameter for us.
        data.insertSub(k, v);
        // We can still access members of the struct - but we should take care not to mess with them.
        return data.size;
    }

    function remove(address k) external returns (uint256) {
        data.remove(k);
        return data.size;
    }

    function size() public view returns (uint256) {
        return data.size;
    }

    function get(address k) public view returns (uint256) {
        return data.get(k);
    }

    // Computes the sum of all stored data.
    function sum() external view returns (uint256 s) {
        for (
            uint256 i = data.iterate_start();
            data.iterate_valid(i);
            i = data.iterate_next(i)
        ) {
            (address key, uint256 value) = data.iterate_get(i);
            s += value;
        }
    }
}
