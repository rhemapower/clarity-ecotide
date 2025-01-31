;; Project Funding Contract

;; Constants
(define-constant err-insufficient-funds (err u300))

;; Data structures
(define-map contributions
  { project-id: uint, contributor: principal }
  { amount: uint }
)

;; Fund a project
(define-public (fund-project (project-id uint) (amount uint))
  (let ((current-balance (stx-get-balance tx-sender)))
    (if (>= current-balance amount)
      (begin
        (try! (stx-transfer? amount tx-sender contract-owner))
        (map-set contributions
          { project-id: project-id, contributor: tx-sender }
          { amount: amount }
        )
        (ok true)
      )
      err-insufficient-funds
    )
  )
)

;; Get contribution amount
(define-read-only (get-contribution (project-id uint) (contributor principal))
  (ok (map-get? contributions { project-id: project-id, contributor: contributor }))
)
