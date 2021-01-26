; calculating the inverse of the following matrix:
; | 4 7 |
; | 2 6 |
;
; look at the file images/matrix_explanation.png for a (admittedly poorly drawn) explanation of the steps

(declare-const I Int) ;1st vertex
(declare-const J Int)

(declare-const K Int) ;2nd vertex
(declare-const L Int)

(declare-const M Int) ;3rd vertex
(declare-const N Int)

(declare-const O Int) ;4th vertex
(declare-const P Int)

(assert

(and

(= (* J N) (+ (* 4 I N) (* 7 M J)))

(= 0 (+ (* 4 K P) (* 7 O L)))

(= 0 (+ (* 2 I N) (* 6 M J)))

(= (* L P) (+ (* 2 K P) (* 6 O L)))

; the following lines are needed because multiplication by 0 is a destructive operation

(not (= 0 J))

(not (= 0 L))

(not (= 0 N))

(not (= 0 P))

))

(check-sat)
(get-model)