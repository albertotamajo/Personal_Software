{-
Now we are going to see how to use the function <*> of Applicative Functors:

1) Just (+3) <*> Just (9) = Just 12
2) pure (+3) <*> Just 10 = Just (+3) <*> Just 10  = Just 13
3) pure (++ " ,Hello") <*>  Just "HI" = Just (++" ,Hello") <*> Just "HI" = Just "HI , Hello"
4) pure (+) <*> Just 3 <*> Just 5 = Just (+) <*> Just 3 <*> Just 5 = Just (3+) <*> Just 5 = Just 8
5) pure (+) <*> Nothing <*> Just 2 = Just (+) <*> Nothing <*> Just 2 = Nothing <*> Just 2 = Nothing

When using Applicatives it is good practice to import Control.Applicative so we can use the <$> function which is defined exactly as fmap
Therefore fmap g (f a) = g <$> (f a)
Thus instead of writing this pure (+3) <*> Just 1o since this is is equivalent to (+3) `fmap` Just 10 we can us the <$> function as the following (+3) <$> Just 10

Examples:

1) (++) <$> Just "johntra" <*> Just "volta" = Just "johntra++" <*> Just "volta" = Just "johntravolta"

Applying <*> with lists:
Let ax be a list of functions and bx be a list of values.
ax <*> bx applies all functions in the left for each value in bx
Examples:
[(0*),(1+),(3*)] <*> [1,2,3] = [0,0,0,2,3,4,3,6,9]
[(*),(+)] <*> [0,1] <*> [3,4] = [(0*),(1*),(0+),(1+)] <*> [3,4] = [0,0,3,4,3,4,4,5]

Example:
Compute all possible prodcuts of the lists [1,2,3] [4,5,6].
We could use a list comprehension but we can use the function <*> too which leads to a more concise code like the follwing:

(*) <$> [1,2,3] <*> [4,5,6] = [x*y | x <- [1,2,3], y <- [4,5,6]]

Example:
filter all the products whose value is greates than 50:

filter $ (*) <$> [1,2,3] <*> [4,5,6]
-}
--Now we are going to see how usig the Applicative style can make our programs very concise
--Write a program that takes two input lines and outputs them together concatenated 
--Without the Applicative style, it would look something like this:
{-
main = do
            fl <- getLine
            sl <- getLine
            let
                line = fl ++ sl
            putStrLn line
-}
-- Applying the applicative style we would get something very concise like the following

main = do
            line <- (++) <$> getLine <*> getLine
            putStrLn line





















