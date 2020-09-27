-- Now we are going to see how to create programs that take command line arguments
-- We are going to use getArgs
-- getArgs :: IO [String]
-- In other words getArgs is an IO action that contains a list of strings whihc are the arguments passed into the command line
--This simple program will just print out the comman line arguments passed when started

import System.Environment

main = do
            args <- getArgs
            mapM putStrLn args