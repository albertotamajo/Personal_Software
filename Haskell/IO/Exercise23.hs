{-
We are going to create a programme that can delete an item in a todo List
In order to create such a programme we will use the following functions:

1) openTempFile :: FilePath -> String -> IO (FilePath, Handle)
2) zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
3) removeFile :: FilePath -> IO ()
4) renameFile :: FilePath -> FilePath -> IO ()
-}

--Let's start buildig such a programme

import System.IO
import System.Directory
import Data.List


main = do
            putStrLn "Write the filepath of the todo list"
            filePath <- getLine
            --We create a tempFile
            (tempFilePath, tempHandle) <- openTempFile "." "temp"
            content <-readFile filePath
            let
                todoLines = lines content
                ntodoLines = zipWith (\a b -> show a++". "++b) [0..] todoLines
                result = unlines ntodoLines
            
            putStrLn result
            putStrLn "What is the item you wanna get rid of?"
            choice <- getLine
            let
                number = read choice
                finalResult = delete (todoLines !! (number)) todoLines
                finalResultUnlined = unlines finalResult
                
            hPutStrLn tempHandle finalResultUnlined 
            removeFile filePath
            hClose tempHandle
            renameFile tempFilePath filePath              
                
                
                
                
                
                
            