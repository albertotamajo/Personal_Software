--An AI tic tac toe game
data Shapes = Cross | Circle | Empty deriving (Show,Eq)

type Position = Int
--The tic tac toe grid
type TTTGrid =  [Shapes]
type Player = Int

--Function that inserts a shape into a tic tac toe puzzle
--The function returns empoty if it is not possible to insert the shape into that position

insertShape :: Shapes -> Position -> TTTGrid -> TTTGrid
insertShape s p g | g!!(p-1) == Empty = fst (foldl (\(acc,index) x -> if index == p then (acc ++ [s], (index +1)) else (acc ++ [x], (index + 1))) ([],1) g)
                  | otherwise = []

--Equals 3 values
equals ::  Shapes -> Shapes -> Shapes -> Bool
equals x y z | x/= Empty && y/= Empty && z/= Empty =  (x == y) && (x==z)
             | otherwise = False


--Function that checks if a given tic tac toe grid is a final state

checkFinalState :: TTTGrid -> Maybe Shapes
checkFinalState g =  case ( filter (\x -> if x /= Nothing then True else False ).fmap (checkFinalStateAuxiliary g)) [(0,1,2),(3,4,5),(6,7,8),(0,3,6),(1,4,7),(2,5,8),(0,4,8),(2,4,6)] of
                            [] -> checkFilledGrid g
                            (x:xs) -> x
                            where
                                checkFilledGrid g = case (and.fmap (\x -> if x /= Empty then True else False)) g of
                                    True -> Just Empty
                                    False -> Nothing
                                


                                       
checkFinalStateAuxiliary ::TTTGrid -> (Position,Position,Position) -> Maybe Shapes
checkFinalStateAuxiliary g (x,y,z) | (equals (g!!x) (g!!y) (g!!z) )&& ((g!!x) /= Empty) = Just (g!!x)
                                   | otherwise = Nothing
                                   


--Function that returns the value of a final state fro the perspective of the artificial player
--The first parameter denotes the shape of the artificial player. The second parameter denotes the shape that has won
valueState :: Shapes -> Shapes -> Int
valueState (Circle) (Cross) = -1
valueState (Circle) (Circle) = 1
valueState (Circle) (Empty) = 0
valueState (Cross) (Circle) = -1
valueState (Cross) (Cross) = 1
valueState (Cross) (Empty) = 0

--Function that generates all possible states of a given state
--An empty state is an action that cannot be performed

generateStates :: Shapes -> TTTGrid -> [TTTGrid]
generateStates s g =  (fmap (\f -> f g).fmap (insertShape s)) [1..9] 

--Function that returns opposite of a shape
oppositeShape :: Shapes -> Shapes
oppositeShape (Cross) = Circle
oppositeShape (Circle) = Cross


--Function that returns the best action that Min player can do
--s1 is the winning shape
--s2 is the shape we need to insert to create a new grid

minValue :: Shapes -> Shapes -> TTTGrid -> Int
minValue s1 s2 g = case checkFinalState g of
                 Just x -> valueState s1 x
                 Nothing -> minimum ( fmap (maxValue s1 (oppositeShape s2)) ((filter (\x -> x /= []).generateStates  s2) g ) )  

                 
maxValue :: Shapes -> Shapes -> TTTGrid -> Int

maxValue s1 s2 g = case checkFinalState g of
                 Just x -> valueState s1 x
                 Nothing -> maximum ( fmap (minValue s1 (oppositeShape s2) ) ( (filter (\x -> x /= []).generateStates  s2 )g)  ) 
                 
--When it is the turn of the Max player this function peforms an action and return a new grid
decisionMaking :: Shapes -> TTTGrid -> TTTGrid
decisionMaking s g = let (m,i) =   foldl (\(max,pos) (value, index) -> if value > max then (value,index) else (max,pos))((-2),(-1)) (zip (fmap (minValueForDecisionMaking s (oppositeShape s)) ( generateStates s g )) [1..]) in insertShape s i g
--(zip (fmap (minValueForDecisionMaking Cross Circle ) ( generateStates Cross g )) [1..])
--Function that prints a tic tac toe game
printTicTacToe :: TTTGrid -> IO ()
printTicTacToe g = do
                        putStrLn "___________________________"
                        putStrLn "|       |        |        |"
                        putStrLn ("|   "++ toString (g!!0)++"   |    "++ toString (g!!1)++"   |   "++ toString (g!!2)++"    |")
                        putStrLn "|       |        |        |"
                        putStrLn "|_______|________|________|"
                        putStrLn "|       |        |        |"
                        putStrLn ("|   "++ toString (g!!3)++"   |    "++ toString (g!!4)++"   |   "++ toString (g!!5)++"    |")
                        putStrLn "|       |        |        |"
                        putStrLn "|_______|________|________|"
                        putStrLn "|       |        |        |"
                        putStrLn ("|   "++ toString (g!!6)++"   |    "++ toString (g!!7)++"   |   "++ toString (g!!8)++"    |")
                        putStrLn "|       |        |        |"
                        putStrLn "|_______|________|________|"

--Function that maps Circle and Cross to thei string representation
toString :: Shapes -> String
toString Circle = "O"
toString Cross = "X"
toString Empty = " "

main = do
            putStrLn "Welcome to this tic tac toe game!!!"
            putStrLn "I am a very skilled AI and I will never let you win unless you are like Isa ...... dumb :)"
            putStrLn "Decide who is going to start. Select 1 if you want me to start or 2 otherwise"
            l <- getLine
            
            
            manageTurnIO (read l) [Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty]
            


--Function that maps 1 and 2 to Cross or Circle

manageTurnIO :: Player -> TTTGrid -> IO ()
manageTurnIO 1 g = do
                        printTicTacToe g
                        case checkFinalState g of
                            Just x -> case x of
                                            Empty -> putStrLn "DRAW"
                                            Cross -> putStrLn "You lost, looser"
                                            Circle -> putStrLn "You won asshole"
                        
                            Nothing -> manageTurnIO 2 (decisionMaking (Cross) g)
                            
manageTurnIO 2 g = do
                    printTicTacToe g
                    case checkFinalState g of
                        Just x -> case x of
                                            Empty -> putStrLn "DRAW"
                                            Cross -> putStrLn "You lost, looser"
                                            Circle -> putStrLn "You won asshole"
                        Nothing -> do
                                        putStrLn "Choose where you want to place your sign"
                                        l <- getLine
                                        let 
                                            n :: Int
                                            n = read l
                                        manageTurnIO 1 ( insertShape  (Circle) n g )
                            
minValueForDecisionMaking :: Shapes -> Shapes -> TTTGrid -> Int
minValueForDecisionMaking _ _ [] = -10
minValueForDecisionMaking s1 s2 g = minValue s1 s2 g
                        
   
   