{-
Now we are going to see how to write to a file.
We need the helpful function called writeFile whose definition is the following:

writeFile :: FilePath -> String -> IO ()

what the function does is to take a filePath, opens the file, gets the handle and write into the handle overwrting what was previously in the file. It will return an IO action
which is empty IO (). If the file does not exist it will be created.
-}

--Programme that gets a filePath interactively and a string and creates or overweite the filePath.

main = do
            putStrLn "Write the filePath"
            filePath <- getLine
            putStrLn "Write the Content to be written into the file"
            content <- getContents
            writeFile filePath content