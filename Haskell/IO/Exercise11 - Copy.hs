--Instead of using sequence (map f list). We can use the following functions:
--mapM
--mapM_
--We can see what the difference between them is by reading their type (we are going to write the type by using only the type IO since we do not know Monads)
-- mapM :: (a-> IO b)->[a]-> IO [b]
-- mapM_ :: (a -> IO b) -> [a] -> IO ()
--In other words what I want to say is that mapM will return as output an IO action while mapM_ won'that
--We are going to write a function that takes input from standard input and output them in reverse order

main = do
          input <- sequence [getLine,getLine,getLine,getLine]
          mapM_ (putStrLn.reverse) input  --By using mapM in the standard output it would be printed IO[(),(),(),()]. This does not occurr with mapM_