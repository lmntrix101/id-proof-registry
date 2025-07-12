;; ------------------------------------------------------------
;; Contract: id-proof-registry
;; Purpose: Register users with identity proofs for decentralized trust
;; License: MIT
;; Author: [Your Name]
;; ------------------------------------------------------------

;; ============ Constants & Errors ============
(define-constant ERR_NOT_ADMIN (err u100))
(define-constant ERR_ALREADY_REGISTERED (err u101))
(define-constant ERR_NOT_REGISTERED (err u102))

;; ============ Admin =============
(define-data-var admin principal tx-sender)

;; ============ Identity Storage ============
(define-map identities
  principal ;; user
  (tuple
    (proof-hash (buff 32)) ;; off-chain proof (hashed email, KYC doc ref, etc.)
    (timestamp uint)
    (verified bool)
  )
)

;; ============ Register Identity ============
(define-public (register-identity (proof-hash (buff 32)))
  (begin
    (asserts! (not (is-some (map-get? identities tx-sender))) ERR_ALREADY_REGISTERED)
    (map-set identities tx-sender {
      proof-hash: proof-hash,
      timestamp: stacks-block-height,
      verified: false
    })
    (ok true)
  )
)

;; ============ Verify Identity (Admin only) ============
(define-public (verify-identity (user principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) ERR_NOT_ADMIN)
    (let ((entry (map-get? identities user)))
      (match entry
        identity-data
        (begin
          (map-set identities user (merge identity-data { verified: true }))
          (ok true)
        )
        ERR_NOT_REGISTERED
      )
    )
  )
)

;; ============ Read-Only Functions ============
(define-read-only (get-identity (user principal))
  (map-get? identities user)
)

(define-read-only (is-verified (user principal))
  (let ((entry (map-get? identities user)))
    (match entry
      data (ok (get verified data))
      ERR_NOT_REGISTERED
    )
  )
)

(define-read-only (get-admin)
  (ok (var-get admin))
)
