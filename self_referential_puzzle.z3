; A certain question has the following answers
; A) all of the below
; B) none of the below
; C) all of the above
; D) one of the above
; E) none of the above
; F) none of the above
; Which answer is the correct answer?

(declare-const A Bool)
(declare-const B Bool)
(declare-const C Bool)
(declare-const D Bool)
(declare-const E Bool)
(declare-const F Bool)

(define-fun a ((B_ Bool) (C_ Bool) (D_ Bool) (E_ Bool) (F_ Bool)) Bool
    (and B_ C_ D_ E_ F_)
)

(define-fun b ((C_ Bool) (D_ Bool) (E_ Bool) (F_ Bool)) Bool
    (not (or C_ D_ E_ F_))
)

(define-fun c ((A_ Bool) (B_ Bool)) Bool
    (and A_ B_)
)

(define-fun d ((A_ Bool) (B_ Bool) (C_ Bool)) Bool
    (xor A_ B_ C_)
)

(define-fun e ((A_ Bool) (B_ Bool) (C_ Bool) (D_ Bool)) Bool
    (not (or A_ B_ C_ D_))
)

(define-fun f ((A_ Bool) (B_ Bool) (C_ Bool) (D_ Bool) (E_ Bool)) Bool
    (not (or A_ B_ C_ D_ E_))
)

(assert

(and

    (= A (a B C D E F))

    (= B (b C D E F))

    (= C (c A B))

    (= D (d A B C))

    (= E (e A B C D))

    (= F (f A B C D E))

))

(check-sat)
(get-model)