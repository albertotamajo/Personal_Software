--Simple Exercise to see how useful Monads can be.
{-
Pierre has decided to take a break from his job at the fish farm and try tightrope walking.
He's not that bad at it, but he does have one problem: birds keep landing on his balancing pole! 
They come and they take a short rest, chat with their avian friends and then take off in search of breadcrumbs. 
This wouldn't bother him so much if the number of birds on the left side of the pole was always equal to the number of birds on the right side. 
But sometimes, all the birds decide that they like one side better and so they throw him off balance, which results in an embarrassing tumble for Pierre (he's using a safety net).

Let's say that he keeps his balance if the number of birds on the left side of the pole and on the right side of the pole is within three.
So if there's one bird on the right side and four birds on the left side, he's okay. But if a fifth bird lands on the left side, then he loses his balance and takes a dive.
-}

type Birds = Int
type Pole = (Birds, Birds) --Birds on the left of the pole and on the right
data Side = L | R

--Function that takes an int and a pole and return a Maybe Pole adding the number of birds on the left side of the Pole
landLeft :: Birds -> Pole -> Maybe Pole
landLeft n (left, right) |  abs ((left +n) - right) > 4 = Nothing
                         | otherwise = Just (left+n, right)
                         
--Same function as above but for landing right
landRight :: Birds -> Pole -> Maybe Pole
landRight n (left, right) |  abs (left - (right+n)) > 4 = Nothing
                          | otherwise = Just (left, right+n)
                         


--Combines the functions above
land :: Birds -> Side -> Pole-> Maybe Pole
land n  (L) p = landLeft n p
land n  (R) p = landRight n p

--Let's define a function that makes Pierre slip
banana :: Pole -> Maybe Pole
banana _ = Nothing

--However, in the case of Maybe we could achieve the same result by using the function >> whihc is defined as the following:
{-
>> :: m a -> m b -> m b
a >> b = a >>= (\_ -> b)
-}

{-
An expression that makes use of the do syntax instead of the function >>= within monads
-}
routine :: Maybe Pole
routine = do
            start <- return (0,0)
            second <- landRight 1 start
            landLeft 1 second
            
--An expression that makes use of the do syntax

routine1 :: Maybe Pole
routine1 = do
             start <- return (0,0)
             Nothing
             landLeft 2 start

--The result of the rotine1 expression is Nothing



