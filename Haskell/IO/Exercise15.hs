--Getting the text from stdin applying a function that takes it and returns another string and the resulted string is printed out is pretty common
--This is why the function interact is pretty useful
-- interact :: (String -> String) -> IO ()
--In other words this is what interact does:
-- 1) Takes string input by using getContents
-- 2) Applies the function entered as argument to the content input
-- 3) The resulting string of the function is printed out
--Thus now we can easily reduce the size of the program in Exercise14 by using interact

--However we have to use a fixed number of characters as we cannot pass this information in the function because it can take as argument only a string

main =  interact onlyShortLines

onlyShortLines :: String ->String -- It takes a string and an integer and return the lines whose length is less than the Int
onlyShortLines xs= let
                            l = lines xs --returns the lines in the string
                            fl = filter (\x -> length x <= 10) l
                            result = unlines fl
                      in
                            result    