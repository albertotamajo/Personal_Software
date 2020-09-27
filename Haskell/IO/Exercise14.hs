--By using getContents I will create a programme that will read a text from the stdin and will retain only those lines that have a length of less than 10 characters
main = do
          length <- getLine
          let 
            number = read length
          contents <- getContents
          putStrLn $ onlyShortLines contents number

onlyShortLines :: String ->Int -> String -- It takes a string and an integer and return the lines whose length is less than the Int
onlyShortLines xs n = let
                            l = lines xs --returns the lines in the string
                            fl = filter (\x -> length x <= n) l
                            result = unlines fl
                      in
                            result                      