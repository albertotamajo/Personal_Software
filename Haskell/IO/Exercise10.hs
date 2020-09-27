--An IO Programme that runs forever by using the function forever of Control.Monad
import Control.Monad
main = forever (do
                  putStrLn "Write something, I will reverse it"
                  line <- getLine
                  putStrLn (reverse line) )