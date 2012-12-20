{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- | Module declares various process-level DSL combinators
module VSim.Runtime.Process where

import Data.Monoid
import qualified Data.IntMap as IntMap
import Control.Applicative
import Control.Monad.Trans
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.BP
import Control.Monad
import Text.Printf

import VSim.Runtime.Monad
import VSim.Runtime.Class
import VSim.Runtime.Time
import VSim.Runtime.Waveform
import VSim.Runtime.Ptr

class (Monad m) => Valueable m x where
    val :: x -> m Int

instance (Monad m) => Valueable m Int where
    val r = return r

instance (MonadMem m) => Valueable m (Ptr Variable) where
    val r = vval `liftM` derefM r

instance (MonadProc m) => Valueable m (Ptr Signal) where
    val r = valueAt1 <$> now <*> (swave `liftM` derefM r)

class (Monad m) => Appendable m x where
    (.++.) :: m x -> m x -> m x

instance (Monad m, Monoid x) => Appendable m x where
    (.++.) ms1 ms2 = mappend `liftM` ms1 `ap` ms2

ms :: (MonadProc m) => Int -> m NextTime
ms t = ticked <$> now <*> (pure $ t * milliSecond)

us :: (MonadProc m) => Int -> m NextTime
us t = ticked <$> now <*> (pure $ t * microSecond)

ps :: (MonadProc m) => Int -> m NextTime
ps t = ticked <$> now <*> (pure $ t * picoSecond)

ns :: (MonadProc m) => Int -> m NextTime
ns t = ticked <$> now <*> (pure $ t * nanoSecond)

fs :: (MonadProc m) => Int -> m NextTime
fs t = ticked <$> now <*> (pure $ t * femtoSecond)

next :: (MonadProc m) => m NextTime
next = fs 1

wait :: (MonadWait m) => m NextTime -> m ()
wait nt = nt >>= wait_until

instance (Valueable VAssign v) => Assignable VAssign (Ptr Signal) v where
    assign mv mr = do
        a <- Assignment <$> mr <*> (PW <$> ask <*> (wconst <$> (val =<< mv)))
        modify (add_assignment a)
        return (acurr a)

instance (Valueable VAssign v) => Assignable VAssign (Ptr Variable) v where
    assign mv mr = mr >>= \r -> (mv >>= val) >>= \v -> updateM (chvar v) r >> return r where
        chvar v var = var { vval = v }

-- FIXME: define the undefined
instance (Valueable VAssign x) => Assignable VAssign (Ptr (Array t x)) (Ptr (Array t x)) where
    assign mv mr = undefined

(.<=.) :: VProc x -> (VProc NextTime, Assigner VAssign x) -> VProc ()
(.<=.) mr (mt,ma) = mr >>= \r -> mt >>= \t -> runVAssign t (ma (return r))

-- | Assigns new value to the variable
(.=.) :: (MonadProc m) => m (Ptr Variable) -> m Int -> m ()
(.=.) mv ma = do
    v' <- ma
    updateM (\(Variable n v c) -> Variable n v' c) =<< mv

add, (.+.) :: (MonadProc m, Valueable m x, Valueable m y) => m x -> m y -> m Int
add ma mb = (+) <$> (val =<< ma) <*> (val =<< mb)
(.+.) = add

minus, (.-.) :: (MonadProc m, Valueable m x, Valueable m y) => m x -> m y -> m Int
minus ma mb = (-) <$> (val =<< ma) <*> (val =<< mb)
(.-.) = minus

greater, (.>.) :: (MonadProc m, Valueable m x, Valueable m y) => m x -> m y -> m Bool
greater ma mb = (>) <$> (val =<< ma) <*> (val =<< mb)
(.>.) = greater

greater_eq, (.>=.) :: (MonadProc m, Valueable m x, Valueable m y) => m x -> m y -> m Bool
greater_eq ma mb = (>=) <$> (val =<< ma) <*> (val =<< mb)
(.>=.) = greater_eq

eq, (.==.) :: (MonadProc m, Valueable m x, Valueable m y) => m x -> m y -> m Bool
eq ma mb = (==) <$> (val =<< ma) <*> (val =<< mb)
(.==.) = eq

-- | Monadic if
iF :: (MonadProc m) => m Bool -> m () -> m () -> m ()
iF exp m1 m2 = exp >>= \ r -> if r then m1 else m2

data ForDirection = To | Downto
    deriving(Show)

-- | Monadic for
for :: (MonadProc m) => (m Int, ForDirection, m Int) -> (Int -> m ()) -> m ()
for (ma,dir,mb) body = do
    a <- ma
    b <- mb
    let indexes To = [a..b]
        indexes Downto = [b..a]
    forM_ (indexes dir) body

instance (MonadProc m) => Imageable m (Ptr Signal) PrimitiveT where
    t_image mr _ = show <$> (valueAt1 <$> now <*> (swave <$> (derefM =<< mr)))

instance (MonadProc m) => Imageable m (Ptr Variable) PrimitiveT where
    t_image mr _ = show <$> (vval <$> (derefM =<< mr))

instance (MonadProc m) => Imageable m Int PrimitiveT where
    t_image mr _ = show <$> mr

