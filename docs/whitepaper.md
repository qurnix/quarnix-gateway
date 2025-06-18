# Quarnix Gateway - MVP
Gasless + cross-chain infra for onboarding Web3 users.
# Quarnix Gateway MVP

## Overview
Quarnix Gateway is a minimal viable prototype (MVP) of a cross-chain and gasless transaction relay system, designed to simplify blockchain interactions for both users and developers.

## Core Features
- **Gasless Transactions**  
  Users sign transactions off-chain. Relayers submit them on-chain using ERC-2771-style forwarding, allowing true zero-gas UX.

- **Bridge-Free Cross-Chain Messaging**  
  Quarnix uses native message-passing and validator-oracle proof logic to relay state across chains without risky asset bridges.

- **Modular Design**  
  Contracts are built in a modular way, enabling future support for multiple L2s and data layers.

## Architecture Summary
