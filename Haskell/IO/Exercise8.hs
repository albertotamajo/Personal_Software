--We are going to use the function 'when' that replaces the flow control statement if (Bool expression) then IO action else IO action
--The function we are going to create takes a string and return a string into the screen unless such a string is the empty string

import Control.Monad
main = do
        line <- getLine
        when (line /= []) (do
                             putStrLn line
                             main)