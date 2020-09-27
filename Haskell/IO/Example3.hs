--This is an IO programme that takes an input repeatedly and unless it is an empty string it pritns it out in reverse order. If the input is an empty string, the programme stops
main = do
          line <- getLine
          if (null line) then
             return ()
          else
             do
                (putStrLn.reverse) line
                main --Recursive call