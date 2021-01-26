; trucks puzzle
;
; there are six trucks
; two of the trucks are cooled

; a truck cannot be heavier than 8000kg
; a truck can only carry 8 pallets
; skipples can only be in a cooled truck
; a truck can only have 1 pallet of nuzzles
; extra requirement:
; a truck can only hold 3 pallets of dupples

; in total, this HAS to be delivered:
; 4 pallets of nuzzles, each of weight 800 kg.
; 8 pallets of skipples, each of weight 1000 kg.
; 8 pallets of crottles, each of weight 1500 kg.
; 12 pallets of dupples, each of weight 400 kg.

; additionally, the maximum number of the following has to be delivered
; A number of pallets of prittles, each of weight 1300 kg.

(declare-datatypes () ((Trucks T1 T2 T3 T4 T5 T6)))
(declare-datatypes () ((Truck (mk-Truck (nuzzles Int) (prittles Int) (skipples Int) (crottles Int) (dupples Int) (cooled Bool)))))

(define-fun isInbetweenRange ((min Int) (max Int) (value Int)) Bool
  (and (>= value min) (<= value max))
)

(declare-fun GetTruck (Trucks) Truck)

(define-fun GetNumOfCooledTrucks () Int
    (+
        (ite (cooled (GetTruck T1)) 1 0)
        (ite (cooled (GetTruck T2)) 1 0)
        (ite (cooled (GetTruck T3)) 1 0)
        (ite (cooled (GetTruck T4)) 1 0)
        (ite (cooled (GetTruck T5)) 1 0)
        (ite (cooled (GetTruck T6)) 1 0)
    )
)

(define-fun GetTotalWeight ((t Truck)) Int
    (+
        (* (nuzzles t) 800)
        (* (prittles t) 1300)
        (* (skipples t) 1000)
        (* (crottles t) 1500)
        (* (dupples t) 400)
    )
)

(define-fun GetNumOfPallets ((t Truck)) Int
    (+
        (nuzzles t)
        (prittles t)
        (skipples t)
        (crottles t)
        (dupples t)
    )
)

(define-fun GetTotalNuzzles () Int
    (+
        (nuzzles (GetTruck T1))
        (nuzzles (GetTruck T2))
        (nuzzles (GetTruck T3))
        (nuzzles (GetTruck T4))
        (nuzzles (GetTruck T5))
        (nuzzles (GetTruck T6))
    )
)

(define-fun GetTotalPrittles () Int
    (+
        (prittles (GetTruck T1))
        (prittles (GetTruck T2))
        (prittles (GetTruck T3))
        (prittles (GetTruck T4))
        (prittles (GetTruck T5))
        (prittles (GetTruck T6))
    )
)

(define-fun GetTotalSkipples () Int
    (+
        (skipples (GetTruck T1))
        (skipples (GetTruck T2))
        (skipples (GetTruck T3))
        (skipples (GetTruck T4))
        (skipples (GetTruck T5))
        (skipples (GetTruck T6))
    )
)

(define-fun GetTotalCrottles () Int
    (+
        (crottles (GetTruck T1))
        (crottles (GetTruck T2))
        (crottles (GetTruck T3))
        (crottles (GetTruck T4))
        (crottles (GetTruck T5))
        (crottles (GetTruck T6))
    )
)

(define-fun GetTotalDupples () Int
    (+
        (dupples (GetTruck T1))
        (dupples (GetTruck T2))
        (dupples (GetTruck T3))
        (dupples (GetTruck T4))
        (dupples (GetTruck T5))
        (dupples (GetTruck T6))
    )
)

(define-fun TruckRestriction ((t Truck)) Bool
    (and
        ; a truck cannot be heavier than 8000kg
        (<= (GetTotalWeight t) 8000)

        ; a truck can only carry 8 pallets
        (<= (GetNumOfPallets t) 8)

        ; skipples can only be stored in trucks that are cooled
        (=>
            (> (skipples t) 0)
            (cooled t)
        )

        ; a truck can only have 1 pallet of nuzzles
        (isInbetweenRange 0 1 (nuzzles t))

        ; a truck can only hold 3 pallets of dupples
        (isInbetweenRange 0 3 (dupples t))

        ; no truck can hold a negative value of pallets
        (>= (prittles t) 0)
        (>= (skipples t) 0)
        (>= (crottles t) 0)
        (>= (dupples t) 0)
    )
)

(assert
    (and
        ; two of the trucks are cooled
        (= GetNumOfCooledTrucks 2)

        ; 4 pallets of nuzzles, each of weight 800 kg.
        (= GetTotalNuzzles 4)

        ; 8 pallets of skipples, each of weight 1000 kg.
        (= GetTotalSkipples 8)

        ; 8 pallets of crottles, each of weight 1500 kg.
        (= GetTotalCrottles 8)

        ; 12 pallets of dupples, each of weight 400 kg.
        (= GetTotalDupples 12)

        ; A number of pallets of prittles, each of weight 1300 kg.
        (> GetTotalPrittles 0)

        (TruckRestriction (GetTruck T1))
        (TruckRestriction (GetTruck T2))
        (TruckRestriction (GetTruck T3))
        (TruckRestriction (GetTruck T4))
        (TruckRestriction (GetTruck T5))
        (TruckRestriction (GetTruck T6))
    )
)

(maximize GetTotalPrittles)

(check-sat)
(get-model)
(get-objectives)