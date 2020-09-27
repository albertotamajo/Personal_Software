--In this exercise I will create a programme that takes an input string from the stdin and then will print out the same number of lines as the input but every line will contain
-- the string "palindrome" if the line was palindrome or "non-palindrome" if the string was not palindrome

main = interact (\x -> (unlines.map (\y -> if y==reverse y then "palindrome" else "non-palindrome").lines) x)