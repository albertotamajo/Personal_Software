{-
We are going to see how to use appendFile.
Its definition:

appendFile :: FilePath -> String -> IO ()

Its type is just like writeFile but it does not overwrite the content of a file but appends to it
-}
import System.IO
main = do
            filePath <- getLine
            content <- getContents
            appendFile filePath content
