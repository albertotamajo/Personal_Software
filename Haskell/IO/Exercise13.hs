--Now we are going to see the getContents function
--The getContentents function reads from the terminal or what is piped to it (using linux pipes) and reads until it encounters an end of file character (CTRL+Z in windows)
-- getContents :: IO String
import Data.Char
--We are going to use the function toUpper whihc will uppercase everything
--This small program just upperCase all lines
--Because of the lazyness of Haskell. When we enter a line, this will be immediately uppered case. Indeed the working of getContents in this specific context can be simulated by the following:
main = do
          forever do
                     line <- getLIne
                     putStrLn  $ map toUpper line
main = do
          input <- getContents
          putStrLn  $ map toUpper input