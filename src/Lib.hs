module Lib
    ( sayHello, ConsoleIO(..), TestIO(..)
    ) where

import Prelude hiding (putStrLn)
import qualified Prelude as P

data TestIO a = PutStrLn String 
 deriving (Show, Eq)

instance ConsoleIO TestIO where
    putStrLn = PutStrLn

class ConsoleIO m  e
    putStrLn :: String -> m ()


sayHello :: (Monad m, ConsoleIO m) => m ()
sayHello = do
    putStrLn "Hello"
    putStrLn "World"

instance ConsoleIO IO where
    putStrLn = P.putStrLn