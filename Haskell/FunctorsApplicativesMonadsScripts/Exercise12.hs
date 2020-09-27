{-
Today, we are going to introduce a new Monad. The WRITER monad which is used mainly for programs that we want to provide with logs
This is how it is defined

newtype Write w a = Writer {runWriter :: (a,w)}

instance (Monoid M) => Monad (Writer w) where
    return x = Writer (x,mempty)
    (Writer (x,v)) >>= f = let (Writer (y,v'))= f x in Writer (y, v `mappend` v')
    
In order to see how it works let's firstly create a function that calculates the gcd between two numbers and then we create the same function but which outputs a log as well
-}
import Control.Monad.Writer
gcd' :: Int -> Int -> Int
gcd' x y | y == 0 = x
         | otherwise = gcd' y (x `mod` y)
         
gcdWriter :: Int -> Int -> Writer [String] Int
gcdWriter x y | y == 0 = do
                            tell ["Finished with "++show x]
                            return x
              | otherwise = do
                                let
                                    r = x `mod` y
                                tell [show x ++ " mod " ++ show y ++ " = " ++ show r ]
                                gcdWriter y (x `mod` y)
         