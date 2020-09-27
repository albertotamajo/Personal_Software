main = do
          putStrLn "Hello, this is me"
          putStrLn "What is your name"
          name <- getLine
          putStrLn ("I got it, your name is " ++ name)