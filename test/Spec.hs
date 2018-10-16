{-# LANGUAGE DataKinds #-}

main :: IO ()
main = putStrLn "to implement"

class Functor f => ConsoleIO f where
    getUserLine :: f String 

instance ConsoleIO IO where
    getUserLine = getLine 

data TestIO a = TestIO a

instance Functor TestIO where
    fmap f (TestIO b) = TestIO (f b) 

instance ConsoleIO TestIO where
    getUserLine = TestIO "line content"

createMain :: a -> IO ()
createMain a = putStrLn "Hello world"


mkMain :: ConsoleIO t => t a -> t ()
mkMain c = 
-- createMain :: Functor t => t a -> IO ()
-- createMain f = putStrLn "Hello world"

