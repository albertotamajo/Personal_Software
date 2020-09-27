--Now we are going to see how to exploit the fact that IO is a functor to obtain a line from the user and reverse it
-- We would do such a thing in the following way:
{-
main = do
            line <- getLine
            let line' = reverse line
            putStrLn line'
-}
--Howwveer we can do such a thing with fewer lines bu using fmap

main = do
            line <- fmap reverse getLine
            putStrLn line