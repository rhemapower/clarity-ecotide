;; Community Management Contract

;; Constants
(define-constant err-not-member (err u200))

;; Data structures
(define-map members
  { address: principal }
  {
    reputation: uint,
    projects-participated: uint,
    join-date: uint
  }
)

;; Join community
(define-public (join-community)
  (map-set members
    { address: tx-sender }
    {
      reputation: u0,
      projects-participated: u0,
      join-date: block-height
    }
  )
  (ok true)
)

;; Get member details  
(define-read-only (get-member-details (address principal))
  (ok (map-get? members { address: address }))
)
