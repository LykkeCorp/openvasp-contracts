pragma solidity ^0.5.0;

library AddressUtils {
    using AddressUtils for AddressUtils.AddressSet;

    struct AddressSet {
        address[] items;
        mapping(address => uint256) indices;
    }

    function add(
        AddressSet storage set,
        address item
    )
        internal
    {
        require(!set.contains(item), "AddressUtils: address set already contains specified address");

        set.items.push(item);
        set.indices[item] = set.items.length;
    }

    function remove(
        AddressSet storage set,
        address item
    )
        internal
    {
        require(set.contains(item), "AddressUtils: address set does not contain specified address");

        uint256 index = set.indices[item] - 1;

        set.items[index] = set.items[set.items.length - 1];
        set.items.pop();

        delete set.indices[item];
    }

    function contains(
        AddressSet storage set,
        address item
    )
        internal view
        returns (bool)
    {
        return set.indices[item] != 0;
    }

    function count(
        AddressSet storage set
    )
        internal view
        returns (uint256)
    {
        return set.items.length;
    }

    function toArray(
        AddressSet storage set,
        uint256 skip,
        uint256 take
    )
        internal view
        returns (address[] memory)
    {
        uint256 length = take;

        if (length > set.items.length - skip) {
            length = set.items.length - skip;
        }

        address[] memory result = new address[](length);

        for (uint256 i = 0; i < length; i++) {
            result[i] = set.items[skip + i];
        }

        return result;
    }
}
