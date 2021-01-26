; four-sided dice puzzle
; https://www.mathsisfun.com/puzzles/four-sided-dice.html

; in this puzzle we have the following distinct letters:
; C
; A
; T
; S
; O
; N
; P
; D
; R
; I
; G
; E

(declare-const C Int)
(declare-const A Int)
(declare-const T Int)
(declare-const S Int)
(declare-const O Int)
(declare-const N Int)
(declare-const P Int)
(declare-const D Int)
(declare-const R Int)
(declare-const I Int)
(declare-const G Int)
(declare-const E Int)

(define-fun equalsSix ((A_ Int) (B_ Int) (C_ Int)) Bool
    (= (+ A_ B_ C_) 6)
)

(define-fun inRange ((I_ Int)) Bool
    (and (>= I_ 1) (<= I_ 3))
)

(assert

(and

    ; the following words must equal six
    (equalsSix C A T)
    (equalsSix S O N)
    (equalsSix P O D)
    (equalsSix R I G)
    (equalsSix P E G)
    (equalsSix T A P)
    (equalsSix D I N)
    (equalsSix A P E)

    ; all of the letters have to be inbetween 1 and 3
    (inRange C)
    (inRange A)
    (inRange T)
    (inRange S)
    (inRange O)
    (inRange N)
    (inRange P)
    (inRange D)
    (inRange R)
    (inRange I)
    (inRange G)
    (inRange E)

    (= (* C A T S O N P D R I G E) 1296)

))

(check-sat)
(get-model)