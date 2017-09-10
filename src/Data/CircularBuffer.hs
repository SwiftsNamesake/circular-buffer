{-|
Module      : Data.CircularBuffer
Description : This module defines a mutable vector a circular (wrap-around) interface
Copyright   : (c) Jonatan Sundqvist, 2017
License     : BSD3
Maintainer  : jonatanhsundqvist@gmail.com
Stability   : stable
Portability : portable

I should probably add @some markup@.
-}

-- TODO | - Nicer interface (eg. accessing fields)
--        - Publish
--        - Polymorphic

-- API -------------------------------------------------------------------------

module Data.CircularBuffer where

-- We'll need these ------------------------------------------------------------

import           Data.IORef                  (IORef, modifyIORef', newIORef,
                                              readIORef)
import           Data.Vector.Unboxed.Mutable as VM
import qualified Data.Vector.Unboxed.Mutable (IOVector, Unbox)

-- Definitions -----------------------------------------------------------------

-- |
data CircularBuffer a = CircularBuffer {
    elements :: VM.IOVector a,
    capacity :: !Int,
    size     :: IORef Int,
    dial     :: IORef Int
}


-- | Create a new 'CircularBuffer' of the given size
new :: Unbox a => Int -> IO (CircularBuffer a)
new sz = CircularBuffer
           <$> VM.new sz
           <*> pure sz
           <*> newIORef 0
           <*> newIORef 0


-- | Add an element to the 'end' of the buffer
append :: Unbox a => CircularBuffer a -> a -> IO (CircularBuffer a)
append (CircularBuffer el cap rsz rdi) a = CircularBuffer
                                             <$> (readIORef rdi >>= \di -> VM.write el di a *> pure el)
                                             <*> (pure cap)
                                             <*> (pure rsz <* modifyIORef' rsz (\sz -> min cap (sz + 1)))
                                             <*> (pure rdi <* modifyIORef' rdi (\di -> mod (di + 1) cap))


-- | Elements in chronological order (FIFO)
toList :: Unbox a => CircularBuffer a -> IO [a]
toList b = do
  sz <- readIORef $ size b
  di <- readIORef $ dial b
  mapM (VM.read $ elements b) [ mod (di + i) sz | i <- [0 .. sz - 1] ]
