--Now we are going to see how the list type is an instance of the Monad classtype
{-
instance Monad [] where
    return x = [x]
    xs >>= f = concat (map f xs)
    fail _ = []
We know that map f xs will produce a list of lists and this is why we use the function concat whihc will flatten the list of lists into a single list.

Example:
[3,4,5] >>= \x -> [x,-x] = [ [3,-3], [4,-4], [5,-5] ] = [3,-3,4,-4,5,-5]

[] >>= (\x -> [x,-x]) = []
-}

--Now we are going to see why list comprehension is just syntactic sugar for applying lists by using the Monad Style
--Let's suppose we have 2 lists [1,2] [3,4] and we want to create all possibe combinations between their elements. We would do this by using list comprehensions in the
--followig way
allCombo :: Num a => [(a,a)]
allCombo = [(x,y) | x <- [1,2], y <- [3,4]]

-- We can aciheve the same result by using the function >>= by the following:
allComboMonad :: Num a => [(a,a)]
allComboMonad = [1,2] >>= (\x -> [3,4] >>= (\y -> return (x,y)))

--We can even achieve the same result by using the do syntax
allComboMonadDo :: Num a => [(a,a)]
allComboMonadDo = do
                    x <- [1,2]
                    y <- [3,4]
                    return (x,y)












