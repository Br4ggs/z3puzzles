; stable marriage problem puzzle
; https://www.geeksforgeeks.org/stable-marriage-problem/

(declare-datatypes () ((Boy B1 B2 B3 B4 B5)))
(declare-datatypes () ((Girl GA GB GC GD GE)))
(declare-datatypes () ((Pair (mk-pair (girl Girl) (boy Boy)))))

(declare-fun PREF_BOY(Boy Int) Girl)
(declare-fun PREF_GIRL(Girl Int) Boy)
(declare-fun GetPair((Int)) Pair)

(declare-const Pair1 (Pair))
(declare-const Pair2 (Pair))
(declare-const Pair3 (Pair))
(declare-const Pair4 (Pair))
(declare-const Pair5 (Pair))

(define-fun SetPreferencesBoy ((b Boy) (g1 Girl) (g2 Girl) (g3 Girl) (g4 Girl) (g5 Girl)) Bool
	(and
		(= (PREF_BOY b 1) g1)
		(= (PREF_BOY b 2) g2)
		(= (PREF_BOY b 3) g3)
		(= (PREF_BOY b 4) g4)
		(= (PREF_BOY b 5) g5)
	)
)

(define-fun SetPreferencesGirl ((g Girl) (b1 Boy) (b2 Boy) (b3 Boy) (b4 Boy) (b5 Boy)) Bool
	(and
		(= (PREF_GIRL g 1) b1)
		(= (PREF_GIRL g 2) b2)
		(= (PREF_GIRL g 3) b3)
		(= (PREF_GIRL g 4) b4)
		(= (PREF_GIRL g 5) b5)
	)
)

(define-fun GetPairScoreGirl ((g Girl) (b Boy)) Int
	(ite (= (PREF_GIRL g 1) b) 5 
	(ite (= (PREF_GIRL g 2) b) 4
	(ite (= (PREF_GIRL g 3) b) 3
	(ite (= (PREF_GIRL g 4) b) 2 1))))
)

(define-fun GetPairScoreBoy ((b Boy) (g Girl)) Int
	(ite (= (PREF_BOY b 1) g) 5 
	(ite (= (PREF_BOY b 2) g) 4 
	(ite (= (PREF_BOY b 3) g) 3 
	(ite (= (PREF_BOY b 4) g) 2 1))))
)

(define-fun GetPairedBoy ((g Girl)) Boy
    (ite (= g (girl Pair1)) (boy Pair1)
    (ite (= g (girl Pair2)) (boy Pair2)
    (ite (= g (girl Pair3)) (boy Pair3)
    (ite (= g (girl Pair4)) (boy Pair4) (boy Pair5)))))
)

(define-fun GetPairedGirl ((b Boy)) Girl
    (ite (= b (boy Pair1)) (girl Pair1)
    (ite (= b (boy Pair2)) (girl Pair2)
    (ite (= b (boy Pair3)) (girl Pair3)
    (ite (= b (boy Pair4)) (girl Pair4) (girl Pair5)))))
)

(assert (and
	(SetPreferencesBoy B1 GC GB GE GA GD)
	(SetPreferencesBoy B2 GA GB GE GC GD)
	(SetPreferencesBoy B3 GD GC GB GA GE)
	(SetPreferencesBoy B4 GA GC GD GB GE)
	(SetPreferencesBoy B5 GA GB GD GE GC)

	(SetPreferencesGirl GA B3 B5 B2 B1 B4)
	(SetPreferencesGirl GB B5 B2 B1 B4 B3)
	(SetPreferencesGirl GC B4 B3 B5 B1 B2)
	(SetPreferencesGirl GD B1 B2 B3 B4 B5)
	(SetPreferencesGirl GE B2 B3 B4 B1 B5)

    (= Pair1 (GetPair 1))
    (= Pair2 (GetPair 2))
    (= Pair3 (GetPair 3))
    (= Pair4 (GetPair 4))
    (= Pair5 (GetPair 5))

	; for each boy, there does not exist a girl for which he has a higher prefference and
	; for which she also prefers him over her current pairing
    (forall ((b Boy))
        (not (exists ((g Girl))
            (and
                (> (GetPairScoreBoy b g) (GetPairScoreBoy b (GetPairedGirl b)))
                (> (GetPairScoreGirl g b) (GetPairScoreGirl g (GetPairedBoy g)))
            )
        ))
    )

    (distinct (boy Pair1) (boy Pair2) (boy Pair3) (boy Pair4) (boy Pair5))
    (distinct (girl Pair1) (girl Pair2) (girl Pair3) (girl Pair4) (girl Pair5))
))

(check-sat)
(get-model)