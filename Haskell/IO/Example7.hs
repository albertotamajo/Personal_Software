--Example of how to use putChar
--putChar :: Char -> IO()
--putChar practically prints out a char into the screen
main = do
         putChar 'h'
         putChar 'e'
         putChar 'l'
         putChar 'l'
         putChar 'o'
         putChar '\n'
         
--In the screen it will be printed out "hello"

--Now we are going to define the function putStr recursively by using putChar
putStr' :: String -> IO()
putStr' [] = return ()
putStr' (x:xs) = do 
                   putChar x  
                   putStr' xs
