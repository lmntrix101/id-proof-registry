 ID Proof Registry - Clarity Smart Contract

**ID Proof Registry** is a Clarity smart contract built for the [Stacks blockchain](https://stacks.co) that allows users to register and verify decentralized identity proofs. It provides a foundation for decentralized KYC, proof-of-humanity systems, and identity-based access control.

---

 Features

-  Register identity metadata on-chain  
-  Admin or trusted authority can verify registered users  
-  Track identity proof records securely  
-  Public lookup of identity status and metadata  
-  Prevent duplicate registration and unauthorized verification  

---

 Contract Functions

 Public Functions

| Function            | Description                                                      |
|---------------------|------------------------------------------------------------------|
| `register-id`       | Allows a user to register their identity metadata and proof hash |
| `verify-id`         | Admin-only function to verify an identity                        |

 Read-Only Functions

| Function             | Description                                     |
|----------------------|-------------------------------------------------|
| `get-id-record`      | Fetches the full identity record for a user     |
| `is-verified`        | Returns whether the user's identity is verified |

---

 Example Usage

```clarity
;; Register user with metadata and proof
(register-id tx-sender 0x4a756c69616e5f446f655f49645f48617368)

;; Verify identity (admin only)
(verify-id 'SP2...XYZ')

;; Read identity record
(get-id-record 'SP2...XYZ')
