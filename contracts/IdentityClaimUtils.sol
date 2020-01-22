pragma solidity ^0.5.0;

import "@openzeppelin/contracts-ethereum-package/contracts/cryptography/ECDSA.sol";
import "./IIdentityClaim.sol";

library IdentityClaimUtils {

    function validateIdentityClaim(
        address identityClaim
    )
        internal view
    {
        validateIdentityClaim(
            IIdentityClaim(identityClaim).issuer(),
            IIdentityClaim(identityClaim).signature(),
            IIdentityClaim(identityClaim).vasp()
        );
    }

    function validateIdentityClaim(
        address issuer,
        bytes memory signature,
        address vasp
    )
        internal pure
    {
        require(issuer != address(0), "IdentityClaimUtils: identity claim issuer is the zero address");
        require(vasp != address(0), "IdentityClaimUtils: identity claim vasp is the zero address");

        bytes32 signedParamsHash = keccak256(abi.encode(vasp));
        address signer = ECDSA.recover(ECDSA.toEthSignedMessageHash(signedParamsHash), signature);

        require(issuer == signer, "IdentityClaimUtils: identity claim signature is invalid");
    }
}
