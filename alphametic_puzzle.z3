;    S E N D
;  + M O R E
; ------------
;  M O N E Y

; Note: you can only do it this way because characters are assured to always
;       only represent a single value (0...9)

(declare-const S Int)
(declare-const E Int)
(declare-const N Int)
(declare-const D Int)
(declare-const M Int)
(declare-const O Int)
(declare-const R Int)
(declare-const Y Int)
(define-fun inRange (x Int)) Bool
    (and (>= x 0) (<= x 9))

; all numbers must be distinct
; must be between 0 and 9
; D + E = Y
; N + R = E
; E + O = N
; (S + M) = ((M * 10) + O)
; 

(assert
(and

(not(= S 0))

(not(= M 0))

(= (+ (* M 10000) (* O 1000) (* N 100) (* E 10) Y) (+ (* S 1000) (* E 100) (* N 10) D (* M 1000) (* O 100) (* R 10) E))

(distinct S E N D M O R Y)

(>= S 0) (<= S 9)

(>= E 0) (<= E 9)

(>= N 0) (<= N 9)

(>= D 0) (<= D 9)

(>= M 0) (<= M 9)

(>= O 0) (<= O 9)

(>= R 0) (<= R 9)

(>= Y 0) (<= Y 9)

))

(check-sat)
(get-model)