{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_circular_buffer (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\Jonatan\\Desktop\\Haskell\\modules\\circular-buffer\\.stack-work\\install\\23cdeb82\\bin"
libdir     = "C:\\Users\\Jonatan\\Desktop\\Haskell\\modules\\circular-buffer\\.stack-work\\install\\23cdeb82\\lib\\x86_64-windows-ghc-8.0.2\\circular-buffer-0.1.0.0-LXs98pV3tAc6KssAaDkw8s"
dynlibdir  = "C:\\Users\\Jonatan\\Desktop\\Haskell\\modules\\circular-buffer\\.stack-work\\install\\23cdeb82\\lib\\x86_64-windows-ghc-8.0.2"
datadir    = "C:\\Users\\Jonatan\\Desktop\\Haskell\\modules\\circular-buffer\\.stack-work\\install\\23cdeb82\\share\\x86_64-windows-ghc-8.0.2\\circular-buffer-0.1.0.0"
libexecdir = "C:\\Users\\Jonatan\\Desktop\\Haskell\\modules\\circular-buffer\\.stack-work\\install\\23cdeb82\\libexec"
sysconfdir = "C:\\Users\\Jonatan\\Desktop\\Haskell\\modules\\circular-buffer\\.stack-work\\install\\23cdeb82\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "circular_buffer_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "circular_buffer_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "circular_buffer_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "circular_buffer_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "circular_buffer_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "circular_buffer_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
