--We have learn that we can use the applicative style with lists and given that a is a list of functions and b is a list of values then a <*> b will apply all the functions in a to all values of b
-- However, what if we want to apply the first function of a to the first value of b, the second function of a to the second value of b and so on?
--In this case we cannot use the list type because the function <*> is already defined. However, there exists a type constructor called ZipList whihc contains a type
-- parameter which is a list. With such a data constructor we can use apply the function <*> over two lists as hypothesized.
--We are going to see how the functions pure and <*> are defined for the ZipList type.
{-
instance Applicative ZipList where
    pure x = ZipList (repeat x)
    ZipList fs <*> Ziplist xs = ZipList (zipWith (\f x -> f x)) fs xs
    
    
Examples:
(+) <$> ZipList [1,2,3] <*> ZipList [100.100,100] = ZipList [(1+),(2+),(3+)] <*> ZipList [100,100,100] = ZipList [101.102,103]
(+) <$> ZipList [1,2,3] <*> ZipList [100,100...] = ZipList [(1+),(2+),(3+)] <*> ZipList [100,100..] = ZipList [101.102,103] Even though ZipList [100,100...] is an infinite list
because of Lazy Evaluation Haskell won't evaluate the whole list but will apply the zipWith function between [[(1+),(2+),(3+)] and [100,100...] and it returns a list with as
many elements as the shortest list, so in this case only 3.

One may wonder why pure x = ZipList (repeat x) and this is because we know that one of the Applicative Laws is that fmap f x = pure f <*> x.
(fmap f x) produces a ZipList containing the same number of elements which are the result of applying the function f to every element of x.
However, pure f <*> x, if pure f was a singleton list containing only one element would produce a ZipList containing only one element. Thus in order to guarantee that fmap f x = pure f <*> x
pure f must be an infinite list of the same function. Because of Lazy Evaluation such a list won't be fully evaluated but only as necessary and depends on the number of elements in the ZipList x

-}