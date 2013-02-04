{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}

module VSim.Runtime.Timewheel (
      timewheel
    ) where

import Control.Applicative
import Control.Monad
import Control.Monad.Trans
import Data.List as List
import Data.Maybe
import Data.Monoid
import Data.Set as Set
import Text.Printf

import VSim.Runtime.Monad
import VSim.Runtime.Time
import VSim.Runtime.Waveform
import VSim.Runtime.Process
import VSim.Runtime.Ptr

data Event = Event [AnyPrimitiveSignal] [Ptr Process]
    deriving(Show)

instance Monoid Event where
    mempty = Event mempty mempty
    mappend (Event a b) (Event x y) = Event (a`mappend`x) (b`mappend`y)

-- | Means that an Event could be extracted from x
class Eventable x where
    next_event :: (MonadMem m) => x -> m (NextTime, Event)

instance Eventable AnyPrimitiveSignal where
    next_event s@(AnyPrimitiveSignal v) = do
        (t,_) <- event <$> swave <$> derefM (vr v)
        return (t, Event [s] [])

instance Eventable (Ptr Process) where
    next_event r = chk <$> pawake <$> derefM r where
        chk Nothing  = (maxBound, Event [] [])
        chk (Just t) = (t       , Event [] [r])

scan_event :: (Eventable e, MonadMem m)
    => [e] -> (NextTime, Event) -> m (NextTime, Event)
scan_event es init = foldM cmp init es where
    cmp (t,e) x = do
        (t',e') <- next_event x
        case (compare t' t) of
            LT -> return (t', e')
            EQ -> return (t, e'`mappend`e)
            _ -> return (t,e)

-- | The simulation algorithm
timewheel :: (Time, SimStep) -> VSim (NextTime, SimStep)
timewheel (t, SimStep ps) = do
    as <- kick_processes
    commit_assignments as
    update_signals

    where

        -- Kicks all the processes from the previous step
        kick_processes = concat <$> mapM kick (Set.toList ps) where
            kick r = do
                p <- derefM r
                ((PP ss nt, PS _ as), h') <- runVProc (phandler p) (PS t [])
                rewind r h' nt
                relink r ss
                return as

        -- FIXME: monitor multiple assignments, implement resolvers
        -- FIXME: for each signal, take only the last assignment into account
        commit_assignments = mapM_ sigassign1

        -- Calculates next event and updates the memory
        -- FIXME: inefficient, loops throw all signals and processes
        update_signals = do
            ss <- uniqSignals <$> get_mem
            ws <- mprocesses <$> get_mem
            (t', es@(Event ss' ps1)) <- (scan_event ss >=> scan_event ws) (maxBound, mempty)
            ps2 <- concat <$> mapM (\(AnyPrimitiveSignal v) -> sigassign2 v) ss'
            return (t', SimStep ((Set.fromList ps1)`mappend`(Set.fromList ps2)))

