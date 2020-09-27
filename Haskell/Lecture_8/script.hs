{-Leaf Tree data type. A leaf tree data type is a tree that contains values only in its leaves-}
--data LTree a = Leaf a | Node (LTree a) (LTree a)  --Recursive definition of a Leaf Tree. In other words an LTree consists of a Leaf or of a node which in turns has 2 subtrees as children 

--Normal Tree that contains values in both leaves and middle nodes
data Tree a = Leaf a | Node a (Tree a) (Tree a)

--Middle Tree data type. A middle Tree data type contains values only in its middle nodes
--data MTree a = Leaf | Node a (MTree a) (MTree a)

{-It is important to notice is that the previous trees are all binary trees. Now we are going to define a Tree whose nodes can contain multiple children-}
--Tree whose nodes can have multiple children
--data MultTree a = Node a [MulTree a]

{-Now we are going to give a definition to RedBlack Trees. Rememeber that in RedBlackTrees there are Red nodes and Black Nodes. Both Middle 
nodes and leaves can contain values. The leaves are always Black. RedBlack Trees are binary-}
--data RBTree a = Leaf a | RedNode a (RBTree a) (RBTree a)| BlackNode a (RBTree a) (RBTree a)

--Function that computes the eight of a RedBlack Tree in terms of its black nodes.
--rbTreeHeight :: RBTree a -> Int
--rbTreeHeight (Leaf _) = 0
--rbTreeHeight (RedNode _ l r) = max (rbTreeHeight l) (rbTreeHeight r)
--rbTreeHeight (BlackNode _ l r) = 1 +  max (rbTreeHeight l) (rbTreeHeight r)

--Now we are going to see how to evaluate expressions containing addition and subtractions
data Expression = Val Int| Add Expression Expression | Subtract Expression Expression
--Function to evaluate an expression
eval :: Expression->Int
eval (Val x)=x
eval (Add x y)= eval x + eval y
eval (Subtract x y) = eval x - eval y

--Now I am going to write a function treeMap which is an Higher-Order Function. It works in a similar way as the higher order function map.
--But while map is used in lists, treeMap will be used to apply a function to the values of the nodes of a tree
treeMap :: (a->b) -> Tree a -> Tree b
treeMap f (Leaf x) = Leaf (f x)
treeMap f (Node x l r) = Node  (f x) (treeMap f l) (treeMap f r)

--Function prints values in a tree
printTree :: Tree a ->[a]
printTree (Leaf x) = x:[]
printTree (Node x l r) = (printTree l) ++ [x] ++ (printTree r) 

--Now we are going to create a data type called Direction which will be used to reach an element in a Tree
--data Direction = L | R
--We are going to call Directions an array of element of type Direction
--type Directions = [Direction]

--elementAt is a function that given a type Directions returns the value of a node
{-elementAt :: Directions-> Tree a -> a
elementAt [] (Node x _ _)=x
elementAt [] (Leaf x)=x
elementAt (R:xs) (Node _ _ r)=elementAt xs r
elementAt (L:xs) (Node _ l _)=elementAt xs l 
-}
--However, by using the strategy above we cannot know how to go up the tree.
--In order to traverse the whole tree, like going left, going right and going up we are going to create 3 function that will do the trick
--However, when moving left or right from a node x we don't need just to store into the stack the direction taken but also what is the value of the
--node x and what is the value of the subtree not taken

data Direction a = L a (Tree a) | R a (Tree a)
type Trail a = [Direction a ]
goLeft :: (Tree a, Trail a) -> (Tree a, Trail a)
goLeft ((Node x l r) ,xs)=(l,(L x r) :xs)

goRight :: (Tree a, Trail a) -> (Tree a, Trail a)
goRight ((Node x l r), xs) = (r, (R x l):xs)

goUp :: (Tree a, Trail a) -> (Tree a, Trail a)
goUp(r, (R x l):xs)=((Node x l r), xs )
goUp (l,(L x r):xs)=((Node x l r),xs)

--Now we are going to give a name to the type (Tree a, Trail a). In functional programming, this is called Zipper
type Zipper a = (Tree a,Trail a) 

printValue :: (Zipper a) -> a
printValue (Leaf a, _)=a
printValue (Node a _ _, _)=a


--Now I am going to define am Higher Order Function that applies a function to the value of the leaf or node contained in the zipper
modify :: (a->a) -> Zipper a -> Zipper a
modify f (Node x l r, ts) = (Node (f x) l r, ts)
modify f (Leaf x , ts) = (Leaf (f x), ts) 



--Now I am going to use the function above to replace a tree in a zipper
replaceTreeInZipper :: Zipper a -> Tree a -> Zipper a
replaceTreeInZipper (_,ts) a = (a,ts)



