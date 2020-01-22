pragma solidity ^0.5.0;

import "@openzeppelin/contracts-ethereum-package/contracts/GSN/Context.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/ownership/Ownable.sol";
import "@openzeppelin/upgrades/contracts/Initializable.sol";
import "./AddressUtils.sol";
import "./AdministratorRole.sol";
import "./IdentityClaimUtils.sol";
import "./IIdentityClaim.sol";
import "./IVASP.sol";

contract VASP is Initializable, Context, Ownable, AdministratorRole, IVASP {
    using AddressUtils for AddressUtils.AddressSet;

    struct PostalAddress {
        string streetName;
        string buildingNumber;
        string addressLine;
        string postCode;
        string town;
        string country;
    }

    uint8[] private _channels;
    string private _email;
    string private _handshakeKey;
    AddressUtils.AddressSet private _identityClaims;
    string private _name;
    PostalAddress _postalAddress;
    string private _signingKey;
    AddressUtils.AddressSet private _trustedPeers;
    string private _website;

    function initialize(
        address owner
    )
        public
        initializer
    {
        Ownable.initialize(owner);
    }

    function addAdministrator(
        address account
    )
        public
        onlyOwner
    {
        _addAdministrator(account);
    }

    function addIdentityClaim(
        address identityClaim
    )
        external
        onlyAdministrator
    {
        IdentityClaimUtils.validateIdentityClaim(identityClaim);

        require(IIdentityClaim(identityClaim).vasp() == address(this), "VASP: identity claim issued to a different VASP");

        _identityClaims.add(identityClaim);
    }

    function addTrustedPeer(
        address trustedPeer
    )
        external
        onlyAdministrator
    {
        _trustedPeers.add(trustedPeer);
    }

    function removeAdministrator(
        address account
    )
        public
        onlyOwner
    {
        _removeAdministrator(account);
    }

    function removeIdentityClaim(
        address identityClaim
    )
        external
        onlyAdministrator
    {
        _identityClaims.remove(identityClaim);
    }

    function removeTrustedPeer(
        address trustedPeer
    )
        external
        onlyAdministrator
    {
        _trustedPeers.remove(trustedPeer);
    }

    function setChannels(
        uint8[] calldata channels
    )
        external
        onlyAdministrator
    {
        _channels = channels;
    }

    function setEmail(
        string calldata email
    )
        external
        onlyAdministrator
    {
        _email = email;
    }

    function setHandshakeKey(
        string calldata handshakeKey
    )
        external
        onlyAdministrator
    {
        _handshakeKey = handshakeKey;
    }

    function setName(
        string calldata name
    )
        external
        onlyAdministrator
    {
        _name = name;
    }

    function setPostalAddress(
        string calldata streetName,
        string calldata buildingNumber,
        string calldata addressLine,
        string calldata postCode,
        string calldata town,
        string calldata country
    )
        external
        onlyAdministrator
    {
        _postalAddress.streetName = streetName;
        _postalAddress.buildingNumber = buildingNumber;
        _postalAddress.addressLine = addressLine;
        _postalAddress.postCode = postCode;
        _postalAddress.town = town;
        _postalAddress.country = country;
    }

    function setSigningKey(
        string calldata signingKey
    )
        external
        onlyAdministrator
    {
        _signingKey = signingKey;
    }

    function setWebsite(
        string calldata website
    )
        external
        onlyAdministrator
    {
        _website = website;
    }

    function channels()
        external view
        returns (uint8[] memory)
    {
        return _channels;
    }

    function code()
        external view
        returns (bytes4)
    {
        bytes memory addressBytes = abi.encodePacked(address(this));

        bytes4 result;
        bytes4 x = bytes4(0xff000000);

        result ^= (x & addressBytes[16]) >> 0;
        result ^= (x & addressBytes[17]) >> 8;
        result ^= (x & addressBytes[18]) >> 16;
        result ^= (x & addressBytes[19]) >> 24;

        return result;
    }

    function email()
        external view
        returns (string memory)
    {
        return _email;
    }

    function handshakeKey()
        external view
        returns (string memory)
    {
        return _handshakeKey;
    }

    function identityClaims(
        uint256 skip,
        uint256 take
    )
        external view
        returns (address[] memory)
    {
        return _identityClaims.toArray(skip, take);
    }

    function identityClaimsCount()
        external view
        returns (uint256)
    {
        return _identityClaims.count();
    }

    function isTrustedPeer(
        address vasp
    )
        external view
        returns (bool)
    {
        return _trustedPeers.contains(vasp);
    }

    function name()
        external view
        returns (string memory)
    {
        return _name;
    }

    function postalAddress()
        external view
        returns (string memory streetName, string memory buildingNumber, string memory addressLine, string memory postCode, string memory town, string memory country)
    {
        streetName = _postalAddress.streetName;
        buildingNumber = _postalAddress.buildingNumber;
        addressLine = _postalAddress.addressLine;
        postCode = _postalAddress.postCode;
        town = _postalAddress.town;
        country = _postalAddress.country;
    }

    function signingKey()
        external view
        returns (string memory)
    {
        return _signingKey;
    }

    function trustedPeers(
        uint256 skip,
        uint256 take
    )
        external view
        returns (address[] memory)
    {
        return _trustedPeers.toArray(skip, take);
    }

    function trustedPeersCount()
        external view
        returns (uint256)
    {
        return _trustedPeers.count();
    }

    function website()
        external view
        returns (string memory)
    {
        return _website;
    }


    uint256[50] private ______gap;
}
