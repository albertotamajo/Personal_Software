--Sliding Program Solver
import Data.List
data Actions = U | D | L | R deriving (Show)
type Squares = Int
type SlGrid = [Squares]
type Size = Int
type Node a b = (a,b) 

--Function that returns index of an element if present in a list
--Returns -1 if the element is not present
findIndex :: Eq a => a -> [a]->Int
findIndex x ys = findIndexAuxiliary x (zip ys [0..])
                    where
                        findIndexAuxiliary _ [] = -1
                        findIndexAuxiliary x ((y,i):ys) | y == x = i
                                                        | otherwise = findIndexAuxiliary x ys
                                                        
--Function that swaps two elements in a given position
swapElements :: Int -> Int -> [a] -> [a]
swapElements x y zs = (fst.foldl (\(acc,index)  p -> if index == x then (acc++[zs!!y], (index+1) ) else if index == y then (acc++[zs!!x],(index+1)) else (acc++[p],(index+1)) ) ([],0)) zs

--Function that given a slide squares grid generates another grid by performing 
generateState :: SlGrid -> Size -> Actions -> Maybe SlGrid
generateState g s U = let
                            indexEs = Main.findIndex 0 g
                            indexRe = (indexEs - s)
                        in
                            if indexRe < 0 then Nothing else Just (swapElements indexEs indexRe  g)

generateState g s D = let
                            indexEs = Main.findIndex 0 g
                            indexRe = (indexEs + s)
                        in
                            if indexRe > ((s^2)-1) then Nothing else Just (swapElements indexEs indexRe  g)
                            
generateState g s L = let
                            indexEs = Main.findIndex 0 g
                            indexRe = (indexEs - 1)
                       in
                            if indexRe < 0 || (indexRe `mod` s == (s-1)) then Nothing else Just (swapElements indexEs indexRe  g)
                            
generateState g s R = let
                            indexEs = Main.findIndex 0 g
                            indexRe = (indexEs + 1)
                       in
                            if indexRe > ((s^2)-1) || (indexRe `mod` s == 0) then Nothing else Just (swapElements indexEs indexRe  g)
                            
--Function that generates all possible states given a state
generateStates :: SlGrid -> Size -> [SlGrid]
generateStates g s = (fmap (\ (Just x) -> x).filter (\x -> x /= Nothing).fmap (generateState g s)) [U,L,R,D]

--Function that prints out a sliding square
printSlSquare :: SlGrid -> IO()
printSlSquare g = do
                        
                        putStrLn "___________________________"
                        putStrLn "|       |        |        |"
                        putStrLn ("|   "++ show (g!!0)++"   |    "++ show (g!!1)++"   |   "++ show (g!!2)++"    |")
                        putStrLn "|       |        |        |"
                        putStrLn "|_______|________|________|"
                        putStrLn "|       |        |        |"
                        putStrLn ("|   "++ show (g!!3)++"   |    "++ show (g!!4)++"   |   "++ show (g!!5)++"    |")
                        putStrLn "|       |        |        |"
                        putStrLn "|_______|________|________|"
                        putStrLn "|       |        |        |"
                        putStrLn ("|   "++ show (g!!6)++"   |    "++ show (g!!7)++"   |   "++ show (g!!8)++"    |")
                        putStrLn "|       |        |        |"
                        putStrLn "|_______|________|________|"

 --Function that runs BFS in the search space of the sliding game
bfsSingleNode :: Size ->Node SlGrid [Actions]  -> [(Node SlGrid [Actions])]
bfsSingleNode s (g,ax)  = filter (\(a,b) -> if a == [] then False else True ) (fmap (f) (zip (fmap (generateState g s) [U,L,R,D]) ([(U:ax),(L:ax),(R:ax),(D:ax)])))
                         where
                            f (Just x,l)= (x,l)
                            f (Nothing,x)=([],x)
                            
bfs :: Size -> [(Node SlGrid [Actions])] -> [(Node SlGrid [Actions])]                            
bfs s xs = concat (fmap (bfsSingleNode s) xs)

--Function that checks whether a given state is a final state
checkFinal :: SlGrid -> Bool
checkFinal g | head g == 0 = sort (tail g) == (tail g)
             | last g == 0 = gExceptLastElement == sort gExceptLastElement
             | otherwise = False
             where
                gExceptLastElement = take ((length g)-1) g

bfsAlgorithm :: Size -> [(Node SlGrid [Actions])] -> [(Node SlGrid [Actions])]
bfsAlgorithm s xs | length listWithFinalStates >= 1 = [result]
                  | otherwise = bfsAlgorithm s (bfs s  xs)
                  where
                        listWithFinalStates = filter (\ (x,y) -> checkFinal x) xs
                        (x,l)= head listWithFinalStates
                        result = (x,reverse l)
                        
--The first parameter is the Stopping function
--The second parameter is the euristic function
--The third parameter is the expanding function
--        
aStarAlgorithm :: Num b => (a -> Bool) -> (a -> b ) -> (a -> [a]) -> [(a,[c])]  --c represents the list of actions that have been maded so far


                            










                            
                    