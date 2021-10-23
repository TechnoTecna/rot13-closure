module Main where

import Caesar (rot13)
import qualified Data.Map as M
import System.Environment (getArgs)
import System.IO (readFile)
import Text.Deburr (deburr)


data Terminality = Terminal | Nonterminal deriving (Eq, Show)
data PrefixTree = Node Terminality (M.Map Char PrefixTree) deriving (Eq, Show)


add :: PrefixTree -> String -> PrefixTree
add (Node _ m) [] = Node Terminal m
add (Node e m) (h:t) =
  case M.lookup h m of
    Nothing -> Node e $ M.insert h (add (Node Nonterminal M.empty) t) m
    Just om -> Node e $ M.insert h (add om t) m

fromList :: [String] -> PrefixTree
fromList = foldl add (Node Nonterminal M.empty)

inTree :: String -> PrefixTree -> Bool
inTree [] (Node Terminal _) = True
inTree [] (Node Nonterminal _) = False
inTree (h:t) (Node _ m) =
  case M.lookup h m of
    Nothing -> False
    Just n2 -> inTree t n2

allPairs :: [String] -> [(String, String)]
allPairs l =
  zip clos $ map rot13 clos
  where
    normL = map deburr l
    clos = filter (\x -> rot13 x `inTree` fromList normL) normL

prettyPrint :: [(String, String)] -> String
prettyPrint = foldl (\x y -> x ++ fst y ++ "/" ++ snd y ++ "\n") ""

main :: IO ()
main = do
  args <- getArgs
  content <- readFile $ head args
  putStr $ prettyPrint $ allPairs $ words content
