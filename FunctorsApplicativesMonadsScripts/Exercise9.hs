{-
Here's a problem that really lends itself to being solved with non-determinism. Say you have a chess board and only one knight piece on it.
We want to find out if the knight can reach a certain position in three moves.
We'll just use a pair of numbers to represent the knight's position on the chess board.
The first number will determine the column he's in and the second number will determine the row.
-}

type KnightPosition = (Int,Int) --The first position of the tuple represents the column while the second position represents the row

moveKnight :: KnightPosition -> [KnightPosition]
moveKnight (l, r) = filter (\(l,r)-> l `elem` [1..8] && r `elem` [1..8]) [(l+2,r-1),(l+2,r+1),(l-2,r-1),(l-2,r+1)  
                                                                          ,(l+1,r-2),(l+1,r+2),(l-1,r-2),(l-1,r+2)]

--Return all positions in the board the knife could be in after 3 moves                                                                          
moveKnight3moves :: KnightPosition -> [KnightPosition]
moveKnight3moves p = moveKnight p >>= moveKnight >>= moveKnight

--Check if the knight could arrive at the expected position after 3 moves
checkExpectedAfter3Moves :: KnightPosition -> KnightPosition -> Bool
checkExpectedAfter3Moves p e = e `elem` (moveKnight3moves p)

