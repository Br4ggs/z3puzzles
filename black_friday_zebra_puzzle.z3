; black friday zebra puzzle
; https://www.brainzilla.com/logic/zebra/black-friday/

(declare-const shirt_black Int)
(declare-const shirt_blue Int)
(declare-const shirt_green Int)
(declare-const shirt_red Int)
(declare-const shirt_white Int)

(declare-const name_dustin Int)
(declare-const name_eugene Int)
(declare-const name_hank Int)
(declare-const name_keith Int)
(declare-const name_sean Int)

(declare-const deal_beard_trimmer Int)
(declare-const deal_game_console Int)
(declare-const deal_laptop Int)
(declare-const deal_smartphone Int)
(declare-const deal_tv Int)

(declare-const deal_40 Int)
(declare-const deal_50 Int)
(declare-const deal_60 Int)
(declare-const deal_70 Int)
(declare-const deal_80 Int)

(declare-const age_25 Int)
(declare-const age_30 Int)
(declare-const age_35 Int)
(declare-const age_40 Int)
(declare-const age_45 Int)

(declare-const juice_apple Int)
(declare-const juice_cranberry Int)
(declare-const juice_grape Int)
(declare-const juice_lemon Int)
(declare-const juice_orange Int)


(define-fun isInbetweenRange ((min Int) (max Int) (value Int)) Bool
  (and (>= value min) (<= value max))
)

(define-fun isLeftOf ((a Int) (b Int)) Bool
    (= (+ a 1) b)
)

(assert
    (and
        ; The man drinking the Orange juice is exactly to the right of the man who got the 70% discount.
        (isLeftOf deal_70 juice_orange)

        ; Keith is 45 years old.
        (= name_keith age_45)

        ; The man who bought the TV is exactly to the left of the man wearing the Red shirt.
        (isLeftOf deal_tv shirt_red)

        ; At the third position is the man who got the 50% discount.
        (= deal_50 3)

        ; Keith is next to the man wearing the White shirt.
        (xor (isLeftOf name_keith shirt_white) (isLeftOf shirt_white name_keith))

        ; The 25-year-old man is somewhere between the 35-year-old man and the 40-year-old man, in that order.
        (and (> age_25 age_35) (< age_25 age_40))

        ; The man drinking Apple juice bought the Smartphone.
        (= juice_apple deal_smartphone)

        ; The 30-year-old man is exactly to the left of the man that bought the Beard trimmer.
        (isLeftOf age_30 deal_beard_trimmer)

        ; Sean is the youngest.
        (= name_sean age_25)

        ; The man that got the 40% discount is exactly to the right of the man who bought the Beard trimmer.
        (isLeftOf deal_beard_trimmer deal_40)

        ; Keith is next to the 35-year-old man.
        (xor (isLeftOf name_keith age_35) (isLeftOf age_35 name_keith))

        ; Eugene is 40 years old.
        (= name_eugene age_40)

        ; Sean is wearing the Black shirt.
        (= name_sean shirt_black)

        ; At the fourth position is the man who got the biggest discount.
        (= 4 deal_80)

        ; Dustin got 60% off.
        (= name_dustin deal_60)

        ; The man drinking the Lemon juice is exactly to the right of the man drinking the Grape juice.
        (isLeftOf juice_grape juice_lemon)

        ; Keith bought a Game console.
        (= name_keith deal_game_console)

        ; The man who got the 80% discount is exactly to the left of the man who is wearing the Blue shirt.
        (isLeftOf deal_80 shirt_blue)

        ; The man drinking Grape juice bought the Beard trimmer.
        (= juice_grape deal_beard_trimmer)

        ; The man wearing the Black shirt is somewhere to the right of Keith.
        (> shirt_black name_keith)

        ; The man that bought the Smartphone is next to the man wearing the Black shirt.
        (xor (isLeftOf deal_smartphone shirt_black) (isLeftOf shirt_black deal_smartphone))

        ; Restrict each number to be only between 1 and 5
        (isInbetweenRange 1 5 shirt_black)
        (isInbetweenRange 1 5 shirt_blue)
        (isInbetweenRange 1 5 shirt_green)
        (isInbetweenRange 1 5 shirt_red)
        (isInbetweenRange 1 5 shirt_white)

        (isInbetweenRange 1 5 name_dustin)
        (isInbetweenRange 1 5 name_eugene)
        (isInbetweenRange 1 5 name_hank)
        (isInbetweenRange 1 5 name_keith)
        (isInbetweenRange 1 5 name_sean)

        (isInbetweenRange 1 5 deal_beard_trimmer)
        (isInbetweenRange 1 5 deal_game_console)
        (isInbetweenRange 1 5 deal_laptop)
        (isInbetweenRange 1 5 deal_smartphone)
        (isInbetweenRange 1 5 deal_tv)

        (isInbetweenRange 1 5 deal_40)
        (isInbetweenRange 1 5 deal_50)
        (isInbetweenRange 1 5 deal_60)
        (isInbetweenRange 1 5 deal_70)
        (isInbetweenRange 1 5 deal_80)

        (isInbetweenRange 1 5 age_25)
        (isInbetweenRange 1 5 age_30)
        (isInbetweenRange 1 5 age_35)
        (isInbetweenRange 1 5 age_40)
        (isInbetweenRange 1 5 age_45)

        (isInbetweenRange 1 5 juice_apple)
        (isInbetweenRange 1 5 juice_cranberry)
        (isInbetweenRange 1 5 juice_grape)
        (isInbetweenRange 1 5 juice_lemon)
        (isInbetweenRange 1 5 juice_orange)

        ; Check if all values in each category are distinct
        (distinct shirt_black shirt_blue shirt_green shirt_red shirt_white)
        (distinct name_dustin name_eugene name_hank name_keith name_sean)
        (distinct deal_beard_trimmer deal_game_console deal_laptop deal_smartphone deal_tv)
        (distinct deal_40 deal_50 deal_60 deal_70 deal_80)
        (distinct age_25 age_30 age_35 age_40 age_45)
        (distinct juice_apple juice_cranberry juice_grape juice_lemon juice_orange)
    )
)

(check-sat)
(get-model)