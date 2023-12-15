# Gno: What, Why, and How

Presented at Web3 Normandy
Rouen, France
December 13, 2023

Speaker: Manfred Touron (@moul)

---

# Sorry, last-minute slides.

---

# What is Gno?

- A new era in smart contracting, and open-source
- Gno: Comprehensive smart contract suite: Gno.land (chain) + Gnolang (language).
- Created by Cosmos co-founder Jae Kwon.

----

## Gno.land

- The first L1 using Gnolang, a Go-based language for smart contracts.
- Built on Tendermint2, Cosmos/IBC, secured by Proof of Contribution.
- Prioritizes simplicity, security, and scalability.
- Gnoweb: Integrated dApp server for contract interactions, no extra servers needed.

----

## Gnolang, a multi-user programming language

- Go-based interpreted language for smart contracting. Powered by GnoVM.
- Multi-user design enhances developer and app interaction. Mixing packages and apps.
- Creates shared virtual environment, akin to developer MMORPG. Custom runtime cycle.
- Contracts start standalone, then grow interconnected for better reusability.

```
                        ┌────────────────────────────┐
                        │                            │
                        │                            ▼
    ┌───────┐       ┌───────┐       ┌───────┐    ┌───────┐
    │   E   │──────▶│   C   │──────▶│   A   │    │   B   │
    └───────┘       └───────┘       └───────┘    └───────┘
        │                               ▲
        │                               │
        └───────────────────────────────┘
```

----

## GnoVM + TM2, a virtual computer

- mixing open-source, open-execution, open-state
- 100% verifiable, auditable, no need to trust a third party
- TM2: Computer
- GnoVM: OS
- Gnolang: API

----

## Gno's Galaxy of Blockchains

- Cosmos ($ATOM) introduced interchain capabilities through:
  - Energy-efficient BFT consensus mechanisms using PoS (Tendermint)
  - Interconnected blockchains (IBC)
  - SDK for developing appChains (Cosmos-SDK)
- IBCx: Secure, typesafe, dynamic GnoVM chain interactions.
- ICSx: Streamlines interchain licensing, validator models, scalability, and security.

----

## Under the (Gn)ood.


```
+---------+   +----------+-------+----------------+
|         |   |          |       |    Gnolang     |
| Wallets |-->|          | GnoVM +----------------+
|         |   |          |       |Execution State |
+---------+   |          +-------+-----+----------+
              | Gno.land |             |   BFT    |
+---------+   |          | Tendermint2 +----------+
|         |   |          |             |IBC + ICS |--interchain-->  ...
|  Gnoweb |-->|          +-------------+----------+
|         |   |          | Proof-of-Contribution  |
+---------+   +----------+------------------------+
```

----

## Gno: Multi-User programming, deep contract interactions

```go
package foobar

import (
    "gno.land/r/foo20" // a grc20 token
    "gno.land/r/users" // equivalent of ENS
)

func TransferToUsername(username string, amount int) {
    user := users.Lookup(username)
    foo20.Transfer(user.Addr(), amount)
}
```


---

# Why Gno?

Web3/Decentralized: like Solidity.
+
Transparent: like GitHub but not only for source.
+
Powerful, Simple, Composable: like Go and Plan9.

----

# Blockchain is not (only) for DeFi

----

## Gno: Why Web3/Decentralized?

- Trusting code over third parties,
- Building a censorship-free knowledge base,
- Creating flexible, trustworthy governance and democracies,
- Supporting web3-dependent people in challenging environments.

----

## Gno: Why Transparent/Interpreted Contracts?

- GitHub shows code but lacks execution proof.
- Solidity details execution but lacks accessible source code.
- Gno Contracts merge open-source code with execution.
- Gno Contracts are callable apps and importable libraries.

----

## Gno: Why a New Language?

- Simple, powerful, secure
- Deterministic
- Interpreted
- Composable
- Auto-Merkelized
- ...

---

# How to Gno More?

- GoR
- Meet the team
- Contribute
- Learn to code
