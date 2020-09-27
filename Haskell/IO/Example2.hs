--This is an IO programme that takes as input a name and a surnames and prints them out in capital letters
import Data.Char
main = do
          putStrLn "What is your first name?"
          name <- getLine
          putStrLn "What is your last name?"
          surname <- getLine
          let
             upperName = map toUpper name
             upperSurname = map toUpper surname
          
          putStrLn ("Your name is: " ++ upperName)
          putStrLn ("Your surname is: "++ upperSurname)