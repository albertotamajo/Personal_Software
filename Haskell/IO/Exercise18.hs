{-
We can use a very helpful function called withFile whhic lets us do what we did in Exercise17 in just one line
This is its definition:
    withFile :: FilePath -> IOMode -> (Handle -> IO a)-> IO a
    
In other words the function takes a file path and an IO Mode and will help us open the file. Then it will apply the function we passed as argument in the extracted handle
and will return the IO action of the function as output.
We can define such a function in the following way:

withFile :: FilePath -> IOMode -> (Handle -> IO a)-> IO a
withfile p i f = do
                    handle <- openFile p i
                    result <- f handle
                    hClose handle
                    return result
-}

--Same program as the one in Exercise17.hs
import System.IO
main = do
            filePath <- getLine
            withFile filePath ReadMode (\handle -> do
                                                        contents <- hGetContents handle
                                                        putStrLn contents)
            
            
