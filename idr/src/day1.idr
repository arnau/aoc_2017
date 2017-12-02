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


solve : Nat -> List Nat -> Nat
solve _ [] = 0
solve n xs = sum (takeTwins (zip xs (shiftBy n xs)))


solve1 : String -> Nat
solve1 raw = solve 1 (toListNat raw)


half : List Nat -> Nat
half [] = 0
half xs = assert_total $ length xs `div` 2


solve2 : String -> Nat
solve2 raw =
    solve (half xs) xs
    where
        xs : List Nat
        xs = toListNat raw
