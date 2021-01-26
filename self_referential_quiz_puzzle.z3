; self-referential quiz
; https://www.brainzilla.com/logic/self-referential-quiz/srq-1/

(declare-const A Int)
(declare-const B Int)
(declare-const C Int)
(declare-const D Int)
(declare-const E Int)

(declare-const Answer1 Int)
(declare-const Answer2 Int)
(declare-const Answer3 Int)
(declare-const Answer4 Int)
(declare-const Answer5 Int)
(declare-const Answer6 Int)
(declare-const Answer7 Int)
(declare-const Answer8 Int)
(declare-const Answer9 Int)
(declare-const Answer10 Int)

(define-fun isInbetweenRange ((min Int) (max Int) (value Int)) Bool
  (and (>= value min) (<= value max))
)

(define-fun getTrueStatement ((optionA Bool) (optionB Bool) (optionC Bool) (optionD Bool) (optionE Bool)) Int
  (ite optionA A 
  (ite optionB B
  (ite optionC C
  (ite optionD D E))))
)

(define-fun countTrueStatements ((value1 Bool) (value2 Bool) (value3 Bool) (value4 Bool) (value5 Bool)) Int
  (+
    (ite value1 1 0) 
    (ite value2 1 0) 
    (ite value3 1 0) 
    (ite value4 1 0) 
    (ite value5 1 0)) 
)

(define-fun countAnswersWithValue ((value Int)) Int
  (+
    (ite (= value Answer1) 1 0) 
    (ite (= value Answer2) 1 0) 
    (ite (= value Answer3) 1 0) 
    (ite (= value Answer4) 1 0) 
    (ite (= value Answer5) 1 0) 
    (ite (= value Answer6) 1 0) 
    (ite (= value Answer7) 1 0) 
    (ite (= value Answer8) 1 0) 
    (ite (= value Answer9) 1 0) 
    (ite (= value Answer10) 1 0))
)

(define-fun countAnswersWithConsonant () Int
  (+
    (ite (or (= B Answer1) (= C Answer1) (= D Answer1)) 1 0) 
    (ite (or (= B Answer2) (= C Answer2) (= D Answer2)) 1 0) 
    (ite (or (= B Answer3) (= C Answer3) (= D Answer3)) 1 0) 
    (ite (or (= B Answer4) (= C Answer4) (= D Answer4)) 1 0) 
    (ite (or (= B Answer5) (= C Answer5) (= D Answer5)) 1 0) 
    (ite (or (= B Answer6) (= C Answer6) (= D Answer6)) 1 0) 
    (ite (or (= B Answer7) (= C Answer7) (= D Answer7)) 1 0) 
    (ite (or (= B Answer8) (= C Answer8) (= D Answer8)) 1 0) 
    (ite (or (= B Answer9) (= C Answer9) (= D Answer9)) 1 0) 
    (ite (or (= B Answer10) (= C Answer10) (= D Answer10)) 1 0))
)

(define-fun isPrime ((value Int)) Bool
    (or
        (= 2 value)
        (= 3 value)
        (= 5 value)
        (= 7 value)
    )
)

(define-fun isCubed ((value Int)) Bool
    (or
        (= 1 value)
        (= 8 value)
    )
)

(define-fun isSquared ((value Int)) Bool
    (or
        (= 1 value)
        (= 4 value)
        (= 9 value)
    )
)

(define-fun isFactorial ((value Int)) Bool
    (or
        (= 1 value)
        (= 2 value)
        (= 6 value)
    )
)

(define-fun isDivisibleBy5 ((value Int)) Bool
    (= 0 (mod value 5))
)

(assert
(and

    (= A 1) ; mapping our answers to integers
    (= B 2) ; just makes things easier to read
    (= C 3)
    (= D 4)
    (= E 5)

    ; Question 1
    (= Answer1
        (getTrueStatement
            (= E Answer1)
            (and
                (not (= E Answer1))
                (= E Answer2)
            )
            (and
                (not (= E Answer1))
                (not (= E Answer2))
                (= E Answer3)
            )
            (and
                (not (= E Answer1))
                (not (= E Answer2))
                (not (= E Answer3))
                (= E Answer4)
            )
            (and
                (not (= E Answer1))
                (not (= E Answer2))
                (not (= E Answer3))
                (not (= E Answer4))
                (= E Answer5)
            )
        )
    )

    ; Question 2
    (xor (= B Answer9) (= B Answer7) (= B Answer5) (= B Answer3) (= B Answer1))
    (= Answer2
        (getTrueStatement
            (= B Answer9)
            (= B Answer7)
            (= B Answer5)
            (= B Answer3)
            (= B Answer1)
        )
    )

    ; Question 3
    (xor
        (= Answer1 Answer2)
        (= Answer2 Answer3)
        (= Answer3 Answer4)
        (= Answer4 Answer5)
        (= Answer5 Answer6)
        (= Answer6 Answer7)
        (= Answer7 Answer8)
        (= Answer8 Answer9)
        (= Answer9 Answer10)
    )
    (= Answer3
        (getTrueStatement
            (= Answer2 Answer3)
            (= Answer3 Answer4)
            (= Answer4 Answer5)
            (= Answer5 Answer6)
            (= Answer6 Answer7)
        )
    )

    ; Question 4
    (xor (= A Answer2) (= A Answer4) (= A Answer6) (= A Answer8) (= A Answer10))
    (= Answer4
        (getTrueStatement
            (= A Answer2)
            (= A Answer4)
            (= A Answer6)
            (= A Answer8)
            (= A Answer10)
        )    
    )

    ; Question 5
    (= Answer5
        (getTrueStatement
            (= 5 (countAnswersWithValue B))
            (= 4 (countAnswersWithValue B))
            (= 3 (countAnswersWithValue B))
            (= 2 (countAnswersWithValue B))
            (= 1 (countAnswersWithValue B))
        )
    )

    ; Question 6
    (= Answer6
        (getTrueStatement
            (and
                (not (= Answer6 Answer9))
                (not (= Answer6 Answer7))
                (not (= Answer6 Answer5))
                (not (= Answer6 Answer3))
                (= Answer6 Answer1)
            )
            (and
                (not (= Answer6 Answer9))
                (not (= Answer6 Answer7))
                (not (= Answer6 Answer5))
                (= Answer6 Answer3)
            )
            (and
                (not (= Answer6 Answer9))
                (not (= Answer6 Answer7))
                (= Answer6 Answer5)
            )
            (and
                (not (= Answer6 Answer9))
                (= Answer6 Answer7)
            )
            (= Answer6 Answer9)
        )
    )

    ; Question 7
    (= Answer7
        (getTrueStatement
            (= Answer7 Answer1)
            (= Answer7 Answer2)
            (= Answer7 Answer3)
            (= Answer7 Answer4)
            (= Answer7 Answer5)
        )
    )

    ; Question 8
    (= Answer8
        (getTrueStatement
            (= 4 (abs (- Answer9 Answer8)))
            (= 3 (abs (- Answer9 Answer8)))
            (= 2 (abs (- Answer9 Answer8)))
            (= 1 (abs (- Answer9 Answer8)))
            (= Answer9 Answer8)
        )
    )

    ; Question 9
    (= Answer9
        (getTrueStatement
            (isPrime countAnswersWithConsonant)
            (isSquared countAnswersWithConsonant)
            (isCubed countAnswersWithConsonant)
            (isDivisibleBy5 countAnswersWithConsonant)
            (isFactorial countAnswersWithConsonant)
        )
    )

    ; Question 10
    (xor (= A Answer10) (= B Answer10) (= C Answer10) (= D Answer10) (= E Answer10))

    (isInbetweenRange A E Answer1)
    (isInbetweenRange A E Answer2)
    (isInbetweenRange A E Answer3)
    (isInbetweenRange A E Answer4)
    (isInbetweenRange A E Answer5)
    (isInbetweenRange A E Answer6)
    (isInbetweenRange A E Answer7)
    (isInbetweenRange A E Answer8)
    (isInbetweenRange A E Answer9)
    (isInbetweenRange A E Answer10)

))

(check-sat)
(get-model)