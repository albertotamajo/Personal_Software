--In this exercise we aregoing to use fmap with the functor IO to get a line from the command line and reverse it, upper case it and intersperse its chars with the character $
import Data.List
import Data.Char
main = do
            line <- fmap (intersperse '-' . reverse . map toUpper) getLine
            putStrLn line