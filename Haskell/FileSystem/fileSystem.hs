--In this Exercise we are goig to create a FileSystem and we are going to navigate it by using Zippers
--We are going to create a FileSystemItem datatype which comprises of a single file or a folder containing multiple FileSystemItem(s)
import Data.List
import System.IO
import Data.List
import Control.Monad
type Name = String
type Data = String
data FSItem = File Name Data | Folder Name [FSItem] deriving (Show, Read)

data FSCrumb = FSCrumb Name [FSItem] [FSItem]  deriving (Show, Read) --It refers to the parent folder name and the two lists are the FSitems prior to or after the current FSItem. It always refers to a folder 
type FSZipper = (FSItem, [FSCrumb])

--Function that lets us go up into our FileSystem tree
main = do
            putStrLn "Write your FileSystem file"
            l <- getLine
            fileSystem <- readFile l
            let
                zipper :: FSZipper
                zipper = (read fileSystem,[])
            (tempName, tempHandle) <- openTempFile "." "temp"
            hPutStrLn tempHandle (show zipper)
            
            --Asks the user for a line
            forever (do
                        (start : xl) <- fmap words getLine
                        content <- hGetContents tempHandle
            
                        let 
                            (Just function) = (lookup start lookUpTable) 
                            x = function  (xl++[content])
                        print x)
       
            
            
lookUpTable = [("lookFSItem ", lookFSItemForMain ),
               ("goUp", goUpForMain),
               ("rename",renameForMain),
               ("deleteFSItem",deleteFSItemForMain),
               ("addFSItem",addFSItemForMain)]
               
               
goUp :: FSZipper -> Either String FSZipper
goUp (item, (FSCrumb name l r : zs)) = Right (Folder name (l++[item]++r), zs)
goUp _ = Left "You cannot go up, you are in the root node"


goUpForMain :: [String] -> Either String FSZipper
goUpForMain (s:[]) = goUp (read s)


--Function that lets us find for a folder or file into a fileSystem folder

lookFSItem :: Name -> FSZipper -> Either String FSZipper
lookFSItem nameToLook (Folder name xs, bs) = case  break isFile xs of
                                                (ls, []) -> Left "The file you are looking for is not here"
                                                (ls, item:rs) -> Right (item, FSCrumb name ls rs : bs)
                                                where
                                                    isFile (File name' _) = name' == nameToLook
                                                    isFile (Folder name' _ ) = name' == nameToLook
lookFSItem _ _ = Left "You must be in a folder in order to look for a FSItem"   -- We are not in a folder thus we cannot look for any FSItem from a file

lookFSItemForMain :: [String] -> Either String FSZipper
lookFSItemForMain (n:z:[]) = lookFSItem n (read z)

saveFileSystem :: FSItem -> IO ()
saveFileSystem f = writeFile "fileSystem.txt" (show f)

readFileSystem :: IO String
readFileSystem = readFile "fileSystem.txt"

--Renames the name of a FSItem
rename :: String -> FSZipper -> Either String FSZipper
rename n (Folder name d , bs) = Right (Folder n d , bs)
rename n (File name ls , bs) = Right (File n ls , bs)

renameForMain :: [String] -> Either String FSZipper
renameForMain (n:z:[]) = rename n (read z)

--Deletes either a file or a folder
deleteFSItem :: FSZipper -> Either String FSZipper
deleteFSItem (_,[]) = Left "You cannot delete the root folder"
deleteFSItem ( _ , (FSCrumb name ls rs) : bs) = Right (Folder name (ls++rs), bs)

deleteFSItemForMain :: [String] -> Either String FSZipper
deleteFSItemForMain (z:[]) = deleteFSItem (read z)


--Adds an FSItem to a folder
addFSItem :: FSItem -> FSZipper -> Either String FSZipper
addFSItem i (Folder name ls, bs) = Right (Folder name (i:ls),bs)
addFSItem _ _ = Left "You can add an FSItem only if you are in a folder" 

addFSItemForMain :: [String] -> Either String FSZipper
addFSItemForMain (i : z : [] ) = addFSItem (read i) (read z)



myDisk :: FSItem  
myDisk = 
    Folder "root"   
        [ File "goat_yelling_like_man.wmv" "baaaaaa"  
        , File "pope_time.avi" "god bless"  
        , Folder "pics"  
            [ File "ape_throwing_up.jpg" "bleargh"  
            , File "watermelon_smash.gif" "smash!!"  
            , File "skull_man(scary).bmp" "Yikes!"  
            ]  
        , File "dijon_poupon.doc" "best mustard"  
        , Folder "programs"  
            [ File "fartwizard.exe" "10gotofart"  
            , File "owl_bandit.dmg" "mov eax, h00t"  
            , File "not_a_virus.exe" "really not a virus"  
            , Folder "source code"  
                [ File "best_hs_prog.hs" "main = print (fix error)"  
                , File "random.hs" "main = print 4"  
                ]  
            ]  
        ] 
        
        
        
        
        