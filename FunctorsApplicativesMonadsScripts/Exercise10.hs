{-
Now we are going to see what Monoids are.
A type m is a Monoid if there exists a function f :: m -> m -> m which is associative (binary) and there exists a value of type m whihc acts as an identity for the function.
In other words, if i is the identity then f i v = v   and   f v i = v.
Now we are going to see how the typeclass Monoid is defined in Haskell:

class Monoid m where
    mempty :: m                               // this represents the identity value of m for the function mappend
    mappend :: m -> m -> m                    // this is the binary associative function with identity value mempty
    mconcat :: [m] -> m                       // transform a list of ms into a single value by using the function foldr applying mappend
    mconcat = foldr mappend mempty
-}