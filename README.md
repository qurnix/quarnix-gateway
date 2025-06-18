# quarnix-gateway
Gasless + cross-chain MVP for Quarnix
# Quarnix Gateway

Gasless Meta-Transaction Forwarder for the Quarnix Protocol (Layer-2)

## ✨ What is this?

This is the minimal prototype for Quarnix’s gasless architecture using the ERC-2771 meta-transaction pattern.

## 🧱 Contracts

- `Forwarder.sol`: Minimal relay forwarder that executes gasless transactions.
- `MetaTxReceiver.sol`: A sample contract that receives meta-transactions.

## 🔧 How it works

1. User signs payload (off-chain).
2. Relayer calls `Forwarder.execute()`.
3. `MetaTxReceiver` extracts real sender via `_msgSender()`.

## 🧪 Testing Flow

You can deploy and test the system in [Remix IDE](https://remix.ethereum.org/):
- Compile `Forwarder.sol` and deploy
- Compile `MetaTxReceiver.sol`, deploy with Forwarder address
- Call `greet()` from MetaTxReceiver and check `Greeted` logs

## 📂 Folder Structure
