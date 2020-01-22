pragma solidity ^0.5.0;

interface IIdentityClaim {

    event Terminated(
        address indexed issuer,
        address indexed vasp,
        bytes signature
    );

    function terminate()
        external;

    function issuer()
        external view
        returns (address);

    function isTerminated()
        external view
        returns (bool);

    function signature()
        external view
        returns (bytes memory);

    function vasp()
        external view
        returns (address);

}
