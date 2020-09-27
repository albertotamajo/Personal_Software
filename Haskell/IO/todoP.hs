--Since now we know how to use command line arguments, we can create a todo program through whihc we pass on arguments and it executes the task assigned in a non interactive way.
-- This todo program will have 3 functionalities:
--      add a new todo item 
--      remove a todo item
--      view the todo list
--The command line arguments must be the following:
--Let todo be the program name
--To view the todo list: todo view filePath
--To delete a todo item: todo delete filePath numberLine
--To add a todo item: todo add filePath todoItemString
--Let's start building such a programme
--In order to create a program we are going to use 3 functions add, remove and view which are called according to a look up table

import System.IO
import System.Environment
import Data.List
import System.Directory

lookUpTable :: [(String, [String] -> IO())]              --This lookupTable maps a string to a function that 
lookUpTable = [("add",add),("delete",Main.delete),("view",view)]
main = do
            (command:args) <- getArgs
            let
                (Just action) = lookup command lookUpTable
            action args

            
add :: [String]->IO ()
add [filePath, todoString] = do
                                appendFile filePath (todoString++"\n")
                                
                                
view :: [String]->IO ()
view (filePath : [] ) = do
                            content <- readFile filePath
                            let
                                todoItems = lines content
                                ntodoItems = zipWith (\a b -> (show a ++ ". " ++ b)) [0..] todoItems
                            putStrLn $ unlines ntodoItems
                            
                        
delete :: [String]-> IO ()
delete (filePath : numberLine : []) = do
                                        content <- readFile filePath
                                        (temFilePath, tempHandle) <- openTempFile "." "temp"
                                        let
                                            number = read numberLine
                                            todolines = lines content
                                            result = Data.List.delete (todolines !! number) todolines
                                         
                                        hPutStr tempHandle $ unlines result
                                        
                                        removeFile filePath
                                        hClose tempHandle
                                        renameFile temFilePath filePath
                                        
                                        
   

        