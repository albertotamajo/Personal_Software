--We have seen that many data types can be folded somehow by using foldl or foldr.
--As we can suspect there exists a classtype called Foldable in Data.Foldabkw which the data types that can be folded can be isntances of.
--It turns out that data types can be instance of this typeclass id they either implement foldr or foldMap.
--However, it turns out that most times implementig foldMap is the easies solution and then we get foldr and foldl for free!!!
--However, I need to see how it uses foldMap to implement foldr and foldl
--We are going to illustrate this with an example whihc will make our Tree data type an instance of Foldable
import qualified Data.Foldable as F
data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

{-
foldMap in Data.Foldable has thr folloeig type:

foldMap :: (Monoid m, Foldable t) => (a-> m) -> t a -> m
In other words with foldMap we can use the function (a->m) to replace all the elements in the foldable with a monoid and then we use mappend to output a single monoid value
-}

instance F.Foldable Tree where
    foldMap f Empty = mempty
    foldMap f (Node a l r) = ( foldMap f l ) `mappend` ( f a ) `mappend` ( foldMap f r )
    
    
testTree = Node (Just 2)  
            (Node (Nothing) 
                (Node (Just 3) Empty Empty)  
                (Node (Just 5) Empty Empty)  
            )  
            (Node (Nothing) 
                (Node (Just 3) Empty Empty)  
                (Node (Just 12) Empty Empty)  
            )  
            
{-
It turns out that because of foldMap we can spot for example if any value in the tree is equal to some other value by using the Any monoid.
As above:
foldMap (\x -> Any (x==3)) testStree   will replace all the  values in the tree with Any True or Any False and then will use mappend to produce an Any True or Any False

We can even use foldmap to convert a tree structure into a list like the following:
foldMap (\x .> [x]) testTree
-}

  