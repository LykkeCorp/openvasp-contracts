pragma solidity ^0.5.0;

import "@openzeppelin/contracts-ethereum-package/contracts/GSN/Context.sol";
import "@openzeppelin/upgrades/contracts/Initializable.sol";
import "./IdentityClaimUtils.sol";
import "./IIdentityClaim.sol";

contract IdentityClaim is Initializable, Context, IIdentityClaim {

    address private _issuer;
    bool private _isTerminated;
    bytes private _signature;
    address private _vasp;

    modifier onlyIssuer()
    {
        require(_msgSender() == _issuer, "IdentityClaim: caller is not the issuer");
        _;
    }

    modifier whenNotTerminated()
    {
        require(!_isTerminated, "IdentityClaim: claim has already been terminated");
        _;
    }

    function initialize(
        address issuer,
        bytes memory signature,
        address vasp
    )
        public
        initializer
    {
        IdentityClaimUtils.validateIdentityClaim(issuer, signature, vasp);

        _issuer = issuer;
        _signature = signature;
        _vasp = vasp;
    }

    function terminate()
        external
        onlyIssuer whenNotTerminated
    {
        _isTerminated = true;

        emit Terminated(_issuer, _vasp, _signature);
    }

    function issuer()
        external view
        returns (address)
    {
        return _issuer;
    }

    function isTerminated()
        external view
        returns (bool)
    {
        return _isTerminated;
    }

    function signature()
        external view
        returns (bytes memory)
    {
        return _signature;
    }

    function vasp()
        external view
        returns (address)
    {
        return _vasp;
    }


    uint256[50] private ______gap;
}
