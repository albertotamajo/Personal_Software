import System.IO
main = do
            filePath <- getLine
            withFile filePath WriteMode (\handle -> do
                                                        hPutStrLn handle "Hello Suca")