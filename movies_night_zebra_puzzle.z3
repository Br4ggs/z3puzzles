; movies night zebra puzzle
; https://www.brainzilla.com/logic/zebra/movies-night/

(declare-const shirt_black Int)
(declare-const shirt_blue Int)
(declare-const shirt_green Int)
(declare-const shirt_red Int)

(declare-const name_daniel Int)
(declare-const name_joshua Int)
(declare-const name_nicholas Int)
(declare-const name_ryan Int)

(declare-const movie_action Int)
(declare-const movie_comedy Int)
(declare-const movie_horror Int)
(declare-const movie_thriller Int)

(declare-const snacks_chips Int)
(declare-const snacks_cookies Int)
(declare-const snacks_crackers Int)
(declare-const snacks_popcorn Int)

(declare-const age_11 Int)
(declare-const age_12 Int)
(declare-const age_13 Int)
(declare-const age_14 Int)

(define-fun isInbetweenRange ((min Int) (max Int) (value Int)) Bool
  (and (>= value min) (<= value max))
)

(assert
    (and
        ; Joshua is in one of the ends.
        (xor (= name_joshua 1) (= name_joshua 4))

        ; The boy wearing the Black shirt is somewhere to the left of the youngest boy.
        (< shirt_black age_11)

        ; Joshua likes Horror movies.
        (= name_joshua movie_horror)

        ; The 14-year-old boy is at the third position.
        (= age_14 3)

        ; The boy wearing the Red shirt is somewhere between the 13-year-old boy and the one who likes Action movies, in that order.
        (and (> shirt_red age_13) (< shirt_red movie_action))

        ; Daniel likes Thriller movies.
        (= name_daniel movie_thriller)

        ; The boy who is going to eat Cookies is in one of the ends.
        (xor (= snacks_cookies 1) (= snacks_cookies 4))

        ; The boy wearing the Black shirt is exactly to the left of the one who likes Thriller movies.
        (= shirt_black (- movie_thriller 1))

        ; The boy who is going to eat Crackers is exactly to the right of the boy who likes Comedy movies.
        (= snacks_crackers (+ movie_comedy 1))

        ; The boy wearing the Red shirt is somewhere between the boy who is going to eat Popcorn and Nicholas, in that order.
        (and (> shirt_red snacks_popcorn) (< shirt_red name_nicholas))

        ; In one of the ends is the boy who likes Thriller movies.
        (xor (= movie_thriller 1) (= movie_thriller 4))

        ; Nicholas is somewhere between Joshua and Daniel, in that order.
        (and (> name_nicholas name_joshua) (< name_nicholas name_daniel))

        ; At the first position is the boy wearing the Green shirt.
        (= shirt_green 1)

        ; Restrict each number to be only between 1 and 4
        (isInbetweenRange 1 4 shirt_black)
        (isInbetweenRange 1 4 shirt_blue)
        (isInbetweenRange 1 4 shirt_green)
        (isInbetweenRange 1 4 shirt_red)

        (isInbetweenRange 1 4 name_daniel)
        (isInbetweenRange 1 4 name_joshua)
        (isInbetweenRange 1 4 name_nicholas)
        (isInbetweenRange 1 4 name_ryan)

        (isInbetweenRange 1 4 movie_action)
        (isInbetweenRange 1 4 movie_comedy)
        (isInbetweenRange 1 4 movie_horror)
        (isInbetweenRange 1 4 movie_thriller)

        (isInbetweenRange 1 4 snacks_chips)
        (isInbetweenRange 1 4 snacks_cookies)
        (isInbetweenRange 1 4 snacks_crackers)
        (isInbetweenRange 1 4 snacks_popcorn)

        (isInbetweenRange 1 4 age_11)
        (isInbetweenRange 1 4 age_12)
        (isInbetweenRange 1 4 age_13)
        (isInbetweenRange 1 4 age_14)

        ; Check if all values in each category are distinct
        (distinct shirt_black shirt_blue shirt_green shirt_red)
        (distinct name_daniel name_joshua name_nicholas name_ryan)
        (distinct movie_action movie_comedy movie_horror movie_thriller)
        (distinct snacks_chips snacks_cookies snacks_crackers snacks_popcorn)
        (distinct age_11 age_12 age_13 age_14)
    )
)

(check-sat)
(get-model)