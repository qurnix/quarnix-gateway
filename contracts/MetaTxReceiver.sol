
# Meta-Transaction Flow

## 🔁 Step-by-Step Flow

1. User signs a payload off-chain using `eth_signTypedData`.
2. The relayer receives the signed data and constructs a transaction for `Forwarder.execute()`.
3. Forwarder verifies:
   - Signature
   - Nonce
   - Timestamp
4. If valid, it forwards the call to the intended contract.
5. Receiver uses `_msgSender()` to get the original sender address.

## 🔐 Security

- Replay protection via `nonce` and `expiry`
- Domain separation for different chains
