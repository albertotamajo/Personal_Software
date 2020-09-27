{-Now we are going to see how to deal with the opening of files, their closure and how to extract the content out of files
The function necessary are the following:
    1) To open a file we need the following function openFile :: FilePath -> IOMode -> IO Handle
    where-
          type FilePath = String
          data IOMode = ReadMode | WriteMode | AppendMode | ReadWriteMode
          IO Handle is an IO action which has as type paramenter an Handle value whihc represents the location of the file into the disk
    2) To extract the content out of a file we need the Handle and we need to use the following function hGetContents :: Handle -> IO String
    where
           the IO String is an IO action that returns as type paramenter a String which holds the content of thr file open
    3) After that we can do something with the content
    4) Before closing the program we need to close thr IO operation using thr function  hClose :: Handle -> IO ()-}
    
 --A program that uses what described above. It opens a file chosen by the user and prints its content out
import System.IO 
main = do
            filePath <- getLine
            handle <- openFile filePath ReadMode
            contents <- hGetContents handle
            putStrLn contents
            hClose handle
           
