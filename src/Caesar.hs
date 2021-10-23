module Caesar
  ( caesar, rot13 )
  where

elemIndex' :: Eq a => Int -> a -> [a] -> Maybe Int
elemIndex' i elm (x:xs)
  | elm == x = Just i
  | otherwise = elemIndex' (i+1) elm xs
elemIndex' _ _ [] = Nothing

elemIndex ::  Eq a => a -> [a] -> Maybe Int
elemIndex = elemIndex' 0

shift :: Eq a => [a] -> Int -> a -> a
shift lst shft elm =
  case elemIndex elm lst of
    Nothing -> elm
    Just i  -> lst !! mod (i + shft) (length lst)

shiftUpper :: Int -> Char -> Char
shiftUpper = shift ['A'..'Z']

shiftLower :: Int -> Char -> Char
shiftLower = shift ['a'..'z']

caesar :: Int -> [Char] -> [Char]
caesar shft = map (shiftUpper shft . shiftLower shft)

rot13 :: String -> String
rot13 = caesar 13
