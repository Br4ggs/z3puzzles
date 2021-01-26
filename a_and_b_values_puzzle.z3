; a and b values puzzle
; consider the following program
; for i := 1 to 10 do
;   if a > b then
;       b := 2b;
;       a := a - 3;
;   else
;       a := 2a;
;       b := b - 5;
;   fi
; od
;
; find initial values for a and b such that afterwards:
; a = 1000 and b = 999

(declare-datatypes () ((LoopIndex I1 I2 I3 I4 I5 I6 I7 I8 I9 I10)))

(declare-fun ValueA (LoopIndex) Int)
(declare-fun ValueB (LoopIndex) Int)

(define-fun Next_LoopIndex ((i LoopIndex)) LoopIndex
	(ite (= i I1) I2
	(ite (= i I2) I3
	(ite (= i I3) I4
	(ite (= i I4) I5
    (ite (= i I5) I6
    (ite (= i I6) I7
    (ite (= i I7) I8
    (ite (= i I8) I9
    (ite (= i I9) I10
                  I1
    )))))))))
)

(assert
    (and
	    (forall ((i LoopIndex)) 
		    (=>
			    (not (= i I10))
			    
                (ite (> (ValueA i) (ValueB i))
                    (and
                        (= (ValueB (Next_LoopIndex i)) (* (ValueB i) 2))
                        (= (ValueA (Next_LoopIndex i)) (- (ValueA i) 3))
                    )

                    (and
                        (= (ValueA (Next_LoopIndex i)) (* (ValueA i) 2))
                        (= (ValueB (Next_LoopIndex i)) (- (ValueB i) 5))
                    )
                )
            )
		)

        (= (ValueA I10) 1000)
        (= (ValueB I10) 999)
    )
)

(check-sat)
(get-model)