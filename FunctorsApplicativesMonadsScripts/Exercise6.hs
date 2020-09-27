--Now we are going to see a useful function called liftA2
--Such a function lets us apply the Applicative style by just calling it when we pass on a binary function
--The type of liftA2 is the following:     liftA2 :: (a->b->c) -> f a -> f b -> f 
{-
liftA2 f a b = f <$> a <*> b

As an example:

liftA2 (++) (Just [1,2,3]) (Just [4,5,6]) = (++) <$> (Just [1,2,3]) <*> Just [4,5,6] = Just ([1,2,3]++) <*> Just [4,5,6] = Just [1,2,3,4,5,6]

Now we are going to see how to transform a list of Applicatives [f a] into f [a].
The function that we are going to dedfine will be called sequenceA

-} 
import Control.Applicative

sequenceA :: (Applicative f ) => [f a] -> f [a]
sequenceA [] = pure []
sequenceA (x:xs) = (:) <$> x <*> Main.sequenceA xs

--Same function but by using the foldr function
sequenceAFold :: (Applicative f ) => [f a] -> f [a]
sequenceAFold = foldr (liftA2 (:)) (pure [])

{-
Now we are going to see why when we use sequenceA with a list of lists we obtain a list containing lists whose number of elements is the same as the number of lists of the fed list
and they represent all possibe combinations of how to combine the lists of the list fed into the function.
 
Example:
sequenceA [[1,2],[3,4]] = [[1,3],[1,4],[2,3],[2,4]] = [[x,y] | x <- [1,2], y <- [3,4]]
Why?
Let's evaluate an example
sequenceA [[1,2],[3,4]] = (:) <$> [1,2] <*> sequnceA [[3,4]] = (:) <$> [1,2] <*> ((:) <$> [3,4] <*> sequenceA []) = (:) <$> [1,2] <*> ((:) <$> [3,4] <*> [ [] ]) =
= (:) <$> [1,2] <*> ( [(3:),(4:)] <*> [ [] ]) = (:) <$> [1,2] <*> [[3],[4]] = [(1:),(2:)] <*> [[3],[4]] = [[1,2],[1,3],[2,3],[2,4]]  












-}
