pragma solidity ^0.5.0;

interface IVASP {

    function channels()
        external view
        returns (uint8[] memory);

    function code()
        external view
        returns (bytes4);

    function email()
        external view
        returns (string memory);

    function handshakeKey()
        external view
        returns (string memory);

    function identityClaims(
        uint256 skip,
        uint256 take
    )
        external view
        returns (address[] memory);

    function identityClaimsCount()
        external view
        returns (uint256);

    function isTrustedPeer(
        address vasp
    )
        external view
        returns (bool);

    function name()
        external view
        returns (string memory);

    function postalAddress()
        external view
        returns (string memory streetName, string memory buildingNumber, string memory addressLine, string memory postCode, string memory town, string memory country);


    function signingKey()
        external view
        returns (string memory);


    function trustedPeers(
        uint256 skip,
        uint256 take
    )
        external view
        returns (address[] memory);

    function trustedPeersCount()
        external view
        returns (uint256);

    function website()
        external view
        returns (string memory);
}
