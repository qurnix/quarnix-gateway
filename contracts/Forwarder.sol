// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Forwarder {
    function execute() public {
        // dummy gasless forwarding
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Forwarder {
    struct ForwardRequest {
        address from;
        address to;
        uint256 value;
        uint256 gas;
        uint256 nonce;
        uint256 expiry;
        bytes data;
    }

    mapping(address => uint256) public nonces;

    function getNonce(address from) public view returns (uint256) {
        return nonces[from];
    }

    function verify(
        ForwardRequest calldata req,
        bytes calldata signature
    ) public view returns (bool) {
        require(block.timestamp <= req.expiry, "Request expired");
        bytes32 hash = keccak256(
            abi.encodePacked(
                req.from,
                req.to,
                req.value,
                req.gas,
                req.nonce,
                req.expiry,
                keccak256(req.data)
            )
        );
        address signer = recoverSigner(hash, signature);
        return signer == req.from && nonces[req.from] == req.nonce;
    }

    function execute(
        ForwardRequest calldata req,
        bytes calldata signature
    ) external payable returns (bool, bytes memory) {
        require(verify(req, signature), "Invalid signature or nonce");
        nonces[req.from] += 1;

        (bool success, bytes memory returndata) = req.to.call{gas: req.gas, value: req.value}(
            abi.encodePacked(req.data, req.from)
        );

        return (success, returndata);
    }

    function recoverSigner(bytes32 hash, bytes calldata signature) internal pure returns (address) {
        bytes32 ethSignedMessageHash = keccak256(
            abi.encodePacked("\x19Ethereum Signed Message:\n32", hash)
        );

        (bytes32 r, bytes32 s, uint8 v) = splitSignature(signature);
        return ecrecover(ethSignedMessageHash, v, r, s);
    }

    function splitSignature(bytes calldata sig)
        internal
        pure
        returns (bytes32 r, bytes32 s, uint8 v)
    {
        require(sig.length == 65, "Invalid signature length");
        assembly {
            r := calldataload(sig.offset)
            s := calldataload(add(sig.offset, 32))
            v := byte(0, calldataload(add(sig.offset, 64)))
        }
    }
}
