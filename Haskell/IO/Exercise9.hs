main = do
            lines <- sequence ([getLine, getLine,getLine,getLine])
            print lines