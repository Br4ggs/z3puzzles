; lying about their age Puzzle
; https://www.mathsisfun.com/puzzles/lying-about-their-age.html

(declare-const DustyAge Int)
(declare-const ErinAge Int)
(declare-const AlexAge Int)
(declare-const BrookAge Int)
(declare-const CodyAge Int)

; "I'm nine years older than Erin."
(define-fun dustyToBrook () Bool
    (= DustyAge (+ ErinAge 9))
)

; "I'm seven years older than Alex."
(define-fun erinToBrook () Bool
    (= ErinAge (+ AlexAge 7))
)

; "Your age is exactly 70% greater than mine."
(define-fun alexToBrook () Bool
    (= BrookAge (* AlexAge 1.7))
)

; "Erin is younger than you."
(define-fun brookToCody1 () Bool
    (> CodyAge ErinAge)
)

; "The difference between your age and Dusty's is the same as the difference between Dusty's and Erin's."
(define-fun brookToCody2 () Bool
    ;(xor (= 6 (- ErinAge DustyAge)) (= -6 (- ErinAge DustyAge)))
    (= (abs (- CodyAge DustyAge)) (abs (- DustyAge ErinAge)))
)

; "The difference between our ages is six years."
(define-fun codyToDusty () Bool
    ;(xor (= 6 (- CodyAge DustyAge)) (= -6 (- CodyAge DustyAge)))
    (= 6 (abs (- CodyAge DustyAge)))
)

; "I'm ten years older than you."
(define-fun codyToAlex1 () Bool
    (= CodyAge (+ AlexAge 10))
)

; "Brook is younger than Dusty."
(define-fun codyToAlex2 () Bool
    (< BrookAge DustyAge)
)

(assert
(and

    (= (< DustyAge BrookAge) dustyToBrook)
    (= (< ErinAge BrookAge) erinToBrook)
    (= (< AlexAge BrookAge) alexToBrook)
    (= (< BrookAge CodyAge) brookToCody1)
    (= (< BrookAge CodyAge) brookToCody2)
    (= (< CodyAge DustyAge) codyToDusty)
    (= (< CodyAge AlexAge) codyToAlex1)
    (= (< CodyAge AlexAge) codyToAlex2)

    (> DustyAge 0)
    (> ErinAge 0)
    (> AlexAge 0)
    (> BrookAge 0)
    (> CodyAge 0)
    
    (distinct DustyAge ErinAge AlexAge BrookAge CodyAge)
))

(check-sat)
(get-model)