;; Project Management Contract

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-not-authorized (err u100))
(define-constant err-invalid-project (err u101))

;; Data structures
(define-map projects
  { project-id: uint }
  {
    owner: principal,
    title: (string-utf8 100),
    description: (string-utf8 500),
    status: (string-ascii 20),
    funding-goal: uint,
    current-funding: uint,
    participant-count: uint
  }
)

(define-data-var project-counter uint u0)

;; Create new project
(define-public (create-project 
  (title (string-utf8 100))
  (description (string-utf8 500))
  (funding-goal uint)
)
  (let ((project-id (var-get project-counter)))
    (map-set projects
      { project-id: project-id }
      {
        owner: tx-sender,
        title: title,
        description: description,
        status: "active",
        funding-goal: funding-goal,
        current-funding: u0,
        participant-count: u0
      }
    )
    (var-set project-counter (+ project-id u1))
    (ok project-id)
  )
)

;; Get project details
(define-read-only (get-project (project-id uint))
  (ok (map-get? projects { project-id: project-id }))
)
