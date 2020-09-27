{-Now we are going to see that it is very simple to get the content (String) out of a file with the useful function called readFile

readFile :: FilePath -> IO String

In other words, the readFile function takes a filePath as an argument and then outputs an Io action which will extract the string content of the file. Thus, we just need to bind
the string part of the IO action 
-}

--Same as Exercise20.hs but by using readFile

import System.IO
main = do
            filePath <- getLine
            content <-readFile filePath
            putStrLn content
 