-- In this exercise we are going to show that fmap f g where f and g are functions is the same as f . g (function composition)
import Data.Char
main = do
            line <- getLine
            let 
                line' = fmap (map toLower) (map toUpper) line   --In the end line' = line because we upper and then lower case it
            putStrLn line'
            
{-
fmap (*3) (+100) :: Num a => a->a    we get a function that gets an input number and sums 100 to it and then multiplies the result by 3. We can write such an expression in the following way:
fmap (*3) (+100) = \x -> (x+100)*3

Therefore we conclude that fmap (*3) (+100) = (*3) . (+100) because . = fmap and we can write by using backward quotes  (*3) `fmap` (+100)

Since, fmap is a curried function then we can see it in multiple ways. Indeed:
Let g a be a functor with type parameter a
Let f :: a->b
1) fmap f (g a) :: (a->b)-> g a-> g b it is a function that takes a function and a functor as arguments and outputs a functor
By using curried definition we can see it in another way:

2) fmap f (g a) :: (a->b)-> ( g a-> g b) that is fmap f is a function that returns another function with input a fanctor and outputs another functor.
This is why fmap id = id according to the first law of functors.

Examples:
fmap (*2) :: (Functor f, Num a) => f a -> f a
fmap (replicate 3) :: (Functor f) => f a -> f [a] 



It follows that if we apply a function that takes on multiple parameters to a functor we get a functor containing a function inside it
Example:
Let g :: a->b->c

fmap g (f a) :: ( f (b->c) )    in other words we get a functor with a function inside from b to c

Practical Examples:

fmap (++) (Just "hey") :: Just ([Char]-> [Char])       where [Char] is synonim of String

fmap (\x y z -> x + y / z) [3,4,5,6] :: Fractional a => [a->a->a]       There is a class constraint because the (/) function is defined only for Fractional instances

-}