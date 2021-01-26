; This puzzle is played on a 5 by 5 board.
; In this puzzle you have to place 5 rooks on the board in
; a way so that every row and collumn only has only one rook occupying it.

(declare-datatypes () ((Row R1 R2 R3 R4 R5)))
(declare-datatypes () ((Column C1 C2 C3 C4 C5)))

(declare-datatypes () ((Rook (mk-Rook (row Row) (column Column)))))
(declare-datatypes () ((Rooks Ro1 Ro2 Ro3 Ro4 Ro5)))

(declare-fun GetRook (Rooks) Rook)

(assert
    (and

        ; no rooks on the same row
        (distinct
            (row (GetRook Ro1))
            (row (GetRook Ro2))
            (row (GetRook Ro3))
            (row (GetRook Ro4))
            (row (GetRook Ro5))
        )

        ; no rooks on the same column
        (distinct
            (column (GetRook Ro1))
            (column (GetRook Ro2))
            (column (GetRook Ro3))
            (column (GetRook Ro4))
            (column (GetRook Ro5))
        )
    )
)

(check-sat)
(get-model)