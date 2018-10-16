{-# OPTIONS_GHC -Werror #-}
module Lib
    ( sayHello, ConsoleIO(..), TestIO(..)
    ) where

import Prelude hiding (putStrLn, getLine)
import qualified Prelude as P
import Data.Monoid

data TestIO a = PutStrLn String | GetLine String (String -> a)

data Free f a = Pure a | Free (f (Free f a))

type TestIOM = Free TestIO

instance (Functor f) => Functor (Free f) where
    f `fmap` Pure a = Pure (f a)
    f `fmap` Free g = Free (fmap (fmap f) g)

instance ConsoleIO TestIO where
    putStrLn = PutStrLn
    getLine prompt = GetLine prompt id

instance Functor TestIO where
    fmap _f (PutStrLn str) = PutStrLn str
    fmap f (GetLine p g)   = GetLine p (f . g)

instance Applicative TestIO where
    pure _a = PutStrLn ""
    f <*> PutStrLn a = PutStrLn a
    PutStrLn s <*> GetLine p g = GetLine p (_foo g)

instance Monad TestIO where
    return = pure
    PutStrLn a >> PutStrLn b = PutStrLn (a <> " " <> b)
    PutStrLn a >>= _f = PutStrLn a

class (Monad m) => ConsoleIO m  where
    putStrLn :: String -> m ()
    getLine :: String -> m String


sayHello :: ConsoleIO m => m ()
sayHello = do
    fn <- getLine "Firstname?"
    ln <- getLine "Lastname?"
    putStrLn fn
    putStrLn ln

instance ConsoleIO IO where
    putStrLn = P.putStrLn
    getLine prompt = P.putStrLn prompt >> P.getLine