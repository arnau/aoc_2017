module Day1

toDigit : Char -> Nat
toDigit '0' = 0
toDigit '1' = 1
toDigit '2' = 2
toDigit '3' = 3
toDigit '4' = 4
toDigit '5' = 5
toDigit '6' = 6
toDigit '7' = 7
toDigit '8' = 8
toDigit '9' = 9
toDigit _ = 0


toListNat : String -> List Nat
toListNat str = map toDigit (unpack str)


takeTwins : List (Nat, Nat) -> List Nat
takeTwins [] = []
takeTwins ((x, y) :: xs) =
    if x == y then x :: takeTwins xs else takeTwins xs


shiftBy : Nat -> List Nat -> List Nat
shiftBy k xs = (drop k xs) ++ (take k xs)


sum' : List Nat -> Nat
sum' [] = 0
sum' xs = sum (takeTwins (zip xs (shiftBy 1 xs)))


solve1 : String -> Nat
solve1 raw = sum' (toListNat raw)

