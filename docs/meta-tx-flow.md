# 🧠 Meta-Transaction Flow

This document explains the step-by-step flow of how Quarnix enables **gasless** transactions using meta-transactions.

---

## 🔁 Step-by-Step Flow

1. **User signs a payload off-chain**  
   - Format: `eth_signTypedData` (EIP-712 compliant)  
   - Contains: destination contract, calldata, nonce, expiry

2. **Relayer receives signed data**  
   - The relayer wraps the payload into a call to `Forwarder.execute()`

3. **Forwarder verifies the transaction**  
   - Signature matches expected signer
   - Nonce is valid (no replay)
   - Timestamp is not expired

4. **If valid**, the `Forwarder` forwards the call to the target contract  
   - Uses `call()` with encoded function data

5. **Target contract (like MetaTxReceiver)** uses `_msgSender()`  
   - Recovers the **original user’s address**
   - Allows business logic to reflect true initiator of the action

---

## 🔐 Security Considerations

- ✅ **Replay Protection**:  
  Every meta-tx includes a `nonce` and `expiry` field  
  → Ensures the transaction can’t be reused

- ✅ **Domain Separation**:  
  Forwarder enforces domain separation via `chainId` checks  
  → Prevents cross-chain replays

- ✅ **Signature Validation**:  
  Uses `ecrecover()` to verify the signed message belongs to the claimed user

---

## 🧰 Tools Used

- `BaseRelayRecipient.sol`: Standard base contract to support `_msgSender()`
- `Forwarder.sol`: Contract that handles validation and forwarding
- `MetaTxReceiver.sol`: Example contract that uses `_msgSender()` to identify original user

---

## 📌 Future Improvements

- Support for batching multiple meta-tx
- Reputation and slashing for malicious relayers
- EIP-2771 standardization alignment

---

## 📎 References

- [EIP-2771: Secure Protocol for Gasless Transactions](https://eips.ethereum.org/EIPS/eip-2771)
- [eth_signTypedData (EIP-712)](https://eips.ethereum.org/EIPS/eip-712)
