--Now that we know the State monad we can create random numbers in avery easy way by using the do expression

import System.Random
import Control.Monad.State
import Data.List

randomS :: (RandomGen g, Random a) => State g a
randomS = State random

mapTable :: [(Bool,String)]
mapTable = [(True, "Head"),(False,"Tail")]

randomThreeCoins :: State StdGen (String,String,String)
randomThreeCoins = do
                        a <- randomS
                        b <- randomS
                        c <- randomS
                        return (lookUp mapTable a, lookUp mapTable b, lookUp mapTable c)

