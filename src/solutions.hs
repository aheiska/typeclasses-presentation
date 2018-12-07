-- map
-------------------------

double :: [Integer] -> [Integer]
double []     = []
double (x : xs) = 2*x : double xs

lens :: [String] -> [Int]
lens []       = []
lens (s : ss) = length s : lens ss

map' :: (a -> b) -> [a] -> [b]
map' _ []       = []
map' f (x : xs) = f x : map' f xs

-- filter
---------------------------

alle5 :: [Int] -> [Int]
alle5 []       = []
alle5 (x : xs) = if x < 5 then x : alle5 xs else alle5 xs

parilliset :: [Integer] -> [Integer]
parilliset [] = []
parilliset (x : xs) = if even x then x : rest else rest
  where
    rest = parilliset xs

parilliset2 [] = []
parilliset2 (x : xs) = if even x then x : parilliset2 xs else parilliset2 xs

evens [] = []
evens (x : xs)
  | even x    = x : rest
  | otherwise = rest
    where rest = evens xs

--posFst :: [(Integer, a)] -> [(Integer, a)]
posFst [] = []
posFst ((a, b) : xs) = if a > 0 then a : posFst xs else posFst xs

evenIndex'' :: [a] -> [a]
evenIndex'' xs = [x | (x, i) <- zip xs [0..], even i]

filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' f (x : xs) = if f x then x : filter' f xs else filter' f xs


-- flatmap
--------------------------

monista :: [(Int, a)] -> [a]
monista []                 = []
monista ((montako, x) : t) = replicate montako x ++ monista t

toista :: [Int] -> [Int]
toista []      = []
toista (h : t) = replicate h h ++ toista t

-- toista is = map (\i -> replicate i i) is

flatmap :: (a -> [b]) -> [a] -> [b]
flatmap _ []       = []
flatmap f (a : as) = f a ++ flatmap f as


flatten :: [[a]] -> [a]
flatten []       = []
flatten (l : ls) = l ++ flatten ls

(|>) x y = y x

flatmap' :: (a -> [b]) -> [a] -> [b]
-- flatmap' f l = flatten (map' f l)
-- flatmap' f = flatten . map' f
flatmap' f l = map f l |> flatten

flatmap'' :: (a -> [b]) -> [a] -> [b]
flatmap'' f l = flatten $ map f l

-- saisko |> :n jotenkin kalvoille :)
-- f#: List.map f |> List.flatten


-- fold
-------------------

summa :: [Integer] -> Integer
summa []       = 0
summa (x : xs) = x + summa xs

tulo []       = 1
tulo (x : xs) = x * tulo xs

cat []       = ""
cat (s : ss) = s ++ cat ss


fold :: (a -> b -> b) -> b -> [a] -> b
fold f z []       = z
fold f z (a : as) = f a (fold f z as)

foldl' :: (b -> a -> b) -> b -> [a] -> b
foldl' _ z []       = z
foldl' f z (a : as) = foldl' f (f z a) as


-- mapf filterf flatmapf
--------------------------------

mapf :: (a -> b) -> [a] -> [b]
mapf f xs = fold (\x acc -> f x : acc) [] xs

reducef :: (a -> a -> a) -> [a] -> a
reducef f (x : xs) = fold f x xs

filterf :: (a -> Bool) -> [a] -> [a]
filterf f xs = fold lf [] xs where
  lf x acc
    | f x       = x : acc
    | otherwise = acc

filterf' :: (a -> Bool) -> [a] -> [a]
--filterf' f as = fold (\x acc -> (if f x then [x] else []) ++ acc) [] as
filterf' f as = fold (\x acc -> if f x then x : acc else acc) [] as

flatmapf :: (a -> [b]) -> [a] -> [b]
flatmapf f l = fold (\a acc -> f a ++ acc) [] l


f :: (Integer, String, [Integer]) -> String
f (1, s, _)  = "yksi plus " ++ s
f (_, _, []) = "tyhjä lista"
f _          = "muu tapaus"

reverse' :: [a] -> [a]
reverse' = foldl (flip (:)) []
