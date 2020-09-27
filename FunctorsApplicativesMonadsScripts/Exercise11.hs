{-
We know that since Haskell is a pure language, data is immutable. Therefore, one may wonders how it is possible to deal with states since data is immutable.
The answer is actually easy because we can create functions (called stateful computations) that take a state and return a tuple with a value and a state.
Stateful Computation s -> (a,s)
We are going to see how this could work by using a stack as our state and two functions pop and push
-}
import Control.Monad.State 
type Stack  a = [a]

{-pop :: Stack a -> (a,Stack a)
pop (s:xs) = (s,xs)

push :: a -> Stack a -> ((),Stack a)
push a s = ((),a:s)
-}

{-
However, what if we want to concatenate many push and pops together?
In this case we cannot directly do it through function application because both function return a tuple and not a stack.
Thus, for example we should do something like this 
-}

--Function that pushes and then pops and then pops again
{-pushPopPop :: Stack Int -> (Int,Stack Int)
pushPopPop s = let
                    ((),state)= push 1 s
                    (_,state1) = pop state
                in
                    pop state1
                -}
{-
However, how you may have already got we can ask help to our Monad typeclass so that we can chain several state computations and because of this a type must be declared
-}                    
{-newtype State s a = State {runState:: s -> (a,s)} --Thus State is just a box that wraps the state computation functions
instance Monad (State s) where
    return x = State (\s -> (x,s))
    (State h) >>= f = State $ \s -> let
                                        (a,newState) = h s
                                        (State g) = f a
                                    in
                                        g newState
                                        
                                        -}
--Therefore now we can write down our push and pop function in terms of the Monad State




pop :: State (Stack Int) Int
pop = state $ \(x:xs) -> (x,xs)  

push :: Int -> State (Stack Int) ()  
push a = state $ \xs -> ((),a:xs)

pushPopPop :: State (Stack Int) Int
pushPopPop = do
                push 3
                pop
                pop

--which is equivalent to the following

pushPopPopM = push 3 >>= (\x -> pop >>= (\y -> pop ))























