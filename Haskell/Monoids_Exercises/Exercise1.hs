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
    
    
The laws of Monoids are the following:

    1) mempty `mappend` x = x                      //Identty value Law
    2) x `mappend` mempty = x                      //Indentity value Law
    3) ( x `mappend` y ) `mappend` z = x `mappend` (y `mappend` z)               //Associative Law
    
Lists are monoids and are defined like the following:

instance Monoid [a] where
    mempty = []
    mappend = (++)
    
As regards numeric types there are actually two different functions that make the numeric types Monoids. These two functions are (+) and (*). So, ow should we do make numeiric types
an instance of Monoid type class. Should we use (+) as mappend or (*) as mappend. Luckily , we do not have to choose because we can wrap numeric types in two contexts and make them
instances of Monoid type class in a different way, one using (+) as mappend and the othert (*) as mappend.

Data.Monoid does this by creating two new types Product and Sum.

newtype Product a = Product {getProduct :: a}
newtype Sum a = Sum {getSum :: a}

instance Num a => Monoid ( Product a ) where
    mempty = Product 1
    mappend (Product x) (Product y) = Product (x*y)

instance Num a => Monoid (Sum a) where
    mempty = Sum 0
    mappend (Sum x) (Sum y) = Sum (x+y)
    
    
    
The Bool type is also a Monoid because of the following two functions (||) and (&&).
We can do a similar way like we did with numeric types.
Indeed, Data.Monoid wraps the Bool type into 2 different types: Any and ALl

newtype Any = Any {getBool :: Bool}
newtype All = All {getBool :: Bool}

instance Monoid Any where
    mempty = Any False
    mappend (Any x) (Any y) = Any (x || y)
    
instance Monoid All where
    mempty = All True
    mappend (All x) (All y) = All (x&&y)

Now we are going to see how the Ordering Data Type is made an instance of Monoid

instance Monoid Ordering where
    mempty = EQ
    mappend LT _ = LT
    mappend GT _ = GT
    mappend EQ x = x
    
We can use such an instance of Monoid when we want to compare two types based on different factors whihc are in an hierarchial relatipnship.
An example will help us understand what we mean by that.
Let's suppose we want to compare two strings according to this hierarchy:

    1) Number of characters
    2) If same number of characters then by number of vowels
    3) Alphabetically
-}


compareStrings :: String -> String -> Ordering
compareStrings x y = ( length x `compare` length y ) `mappend` (length x' `compare` length y') `mappend` (x `compare` y)
                     where
                        x' = filter (\x -> x `elem` "aeiou") x
                        y' = filter (\x -> x `elem` "aeiou") y
                        
--By exploiting the Monoid characteristic of Ordering we are going to give a different definition to the function to compare two strings in an alphanumeric way

compare' :: String -> String -> Ordering
compare' [] [] = EQ
compare' [] _ = LT
compare' _ [] = GT
compare' (x:xs) (y:ys) = ( x `compare` y ) `mappend` ( compare' xs ys )






















