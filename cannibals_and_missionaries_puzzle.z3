; cannibals and missionaries puzzle
; https://www.mcs.anl.gov/~wos/mathproblems/missionaries.html

; the shortest time this puzzle can be done in is 11 steps
(declare-datatypes () ((Timestamp T1 T2 T3 T4 T5 T6 T7 T8 T9 T10 T11 T12)))

(declare-fun Missionaries_left_of_river (Timestamp) Int)
(declare-fun Missionaries_right_of_river (Timestamp) Int)

(declare-fun Cannibals_left_of_river (Timestamp) Int)
(declare-fun Cannibals_right_of_river (Timestamp) Int)

(define-fun People_left_of_river ((t Timestamp)) Int
    (+ (Missionaries_left_of_river t) (Cannibals_left_of_river t))
)

(define-fun People_right_of_river ((t Timestamp)) Int
    (+ (Missionaries_right_of_river t) (Cannibals_right_of_river t))
)

(define-fun Next_Timestamp ((t Timestamp)) Timestamp
	(ite (= t T1)  T2
	(ite (= t T2)  T3
	(ite (= t T3)  T4
	(ite (= t T4)  T5
    (ite (= t T5)  T6
    (ite (= t T6)  T7
    (ite (= t T7)  T8
    (ite (= t T8)  T9
    (ite (= t T9)  T10
    (ite (= t T10) T11
    (ite (= t T11) T12
                   T1
    )))))))))))
)

(define-fun isInbetweenRange ((min Int) (max Int) (value Int)) Bool
  (and (>= value min) (<= value max))
)

(assert
    (and
        ; at the beginning both all of the missionaries and cannibals
        ; are positioned on the right side of the river
        (= (Missionaries_right_of_river T1) 3)
        (= (Missionaries_left_of_river T1) 0)

        (= (Cannibals_right_of_river T1) 3)
        (= (Cannibals_left_of_river T1) 0)

        ; at the final timestamp, all of the missionaries and cannibals
        ; must have moved to the left side of the river
        (= (Missionaries_right_of_river T12) 0)
        (= (Missionaries_left_of_river T12) 3)

        (= (Cannibals_right_of_river T12) 0)
        (= (Cannibals_left_of_river T12) 3)

        ; for all of the timestamps:
        ; the amount of missionaries and cannibals on the
        ; left and right side of the river cannot be above 3 or below 0
        ; the total amount of missionaries must equal 3
        ; the total amount of cannibals must equal 3
        ; the total amount of people must equal 6
        ; additionally: if a riverside has missionaries on it, the
        ; amount of cannibals on that riverside must be lower or equal to the
        ; amount of missionaries
        (forall ((t Timestamp))
            (and
                (isInbetweenRange 0 3 (Missionaries_left_of_river t))
                (isInbetweenRange 0 3 (Missionaries_right_of_river t))
                (isInbetweenRange 0 3 (Cannibals_left_of_river t))
                (isInbetweenRange 0 3 (Cannibals_right_of_river t))

                (= (+ (Missionaries_left_of_river t) (Missionaries_right_of_river t)) 3)
                (= (+ (Cannibals_left_of_river t) (Cannibals_right_of_river t)) 3)

                (=> (> (Missionaries_left_of_river t) 0)
                    (>= (Missionaries_left_of_river t) (Cannibals_left_of_river t))
                )

                (=> (> (Missionaries_right_of_river t) 0)
                    (>= (Missionaries_right_of_river t) (Cannibals_right_of_river t))
                )

                (= (+ (People_left_of_river t) (People_right_of_river t)) 6)

                ; we dont check timestamp T12 since its the last timestamp we don't
                ; move any cannibals or missionaries for the next timestamp

                ; for timestamps T1, T3, T5, T7, T9 and T11 the boat must cross from
                ; right to left
                (=>
                    (xor
                        (= t T1)
                        (= t T3)
                        (= t T5)
                        (= t T7)
                        (= t T9)
                        (= t T11)
                    )
                    
                    (and
                        ; check that the number of missionaries/cannibals on the right side of the river for this timestamp
                        ; is greater or equal to the number of missionaries/cannibals on the next timestamp
                        (>= (Missionaries_right_of_river t) (Missionaries_right_of_river (Next_Timestamp t)))
                        (>= (Cannibals_right_of_river t) (Cannibals_right_of_river (Next_Timestamp t)))

                        ; check that the number of missionaries/cannibals on the left side of the river for this timestamp
                        ; is smaller or equal to the number of missionaries/cannibals on the next timestamp
                        (<= (Missionaries_left_of_river t) (Missionaries_left_of_river (Next_Timestamp t)))
                        (<= (Cannibals_left_of_river t) (Cannibals_left_of_river (Next_Timestamp t)))

                        (xor
                            ; one person is going to cross from right to left
                            (and
                                (= (- (People_right_of_river t) (People_right_of_river (Next_Timestamp t))) 1)
                                (= (- (People_left_of_river (Next_Timestamp t)) (People_left_of_river t)) 1)
                            )

                            ; two people are going to cross from right to left
                            (and
                                (= (- (People_right_of_river t) (People_right_of_river (Next_Timestamp t))) 2)
                                (= (- (People_left_of_river (Next_Timestamp t)) (People_left_of_river t)) 2)
                            )
                        )
                    )
                )

                ; for timestamps T2, T4, T6, T8 and T10 the boat must cross from
                ; left to right
                (=>
                    (xor
                        (= t T2)
                        (= t T4)
                        (= t T6)
                        (= t T8)
                        (= t T10)
                    )

                    (and
                        ; check that the number of missionaries/cannibals on the left side of the river for this timestamp
                        ; is greater or equal to the number of missionaries/cannibals on the next timestamp
                        (>= (Missionaries_left_of_river t) (Missionaries_left_of_river (Next_Timestamp t)))
                        (>= (Cannibals_left_of_river t) (Cannibals_left_of_river (Next_Timestamp t)))

                        ; check that the number of missionaries/cannibals on the right side of the river for this timestamp
                        ; is smaller or equal to the number of missionaries/cannibals on the next timestamp
                        (<= (Missionaries_right_of_river t) (Missionaries_right_of_river (Next_Timestamp t)))
                        (<= (Cannibals_right_of_river t) (Cannibals_right_of_river (Next_Timestamp t)))

                        (xor
                            ; one person is going to cross from left to right
                            (and
                                (= (- (People_left_of_river t) (People_left_of_river (Next_Timestamp t))) 1)
                                (= (- (People_right_of_river (Next_Timestamp t)) (People_right_of_river t)) 1)
                            )

                            ; two people are going to cross from left to right
                            (and
                                (= (- (People_left_of_river t) (People_left_of_river (Next_Timestamp t))) 2)
                                (= (- (People_right_of_river (Next_Timestamp t)) (People_right_of_river t)) 2)
                            )
                        )
                    )
                )
            )
        )
    )
)

(check-sat)
(get-model)