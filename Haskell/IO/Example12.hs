--Now I am going to introduce forM. forM works exactly like mapM but its first argument is a list and its second a function.
--Since, the second argument is a function, we can write a long lamba expression and this is made easier than in mapM because the function is the second (last) argument.

-- This is a programme that takes as input 4 strings and associates 4 colors to them
import Control.Monad
main = do
          lines <- sequence [getLine,getLine,getLine,getLine]
          choices <- forM lines (\a -> (do
                                            putStrLn $ "What is the color you wanna match with "++ a ++ " ?"
                                            choice <- getLine
                                            return choice))
          mapM_ print (zip lines choices)
                               