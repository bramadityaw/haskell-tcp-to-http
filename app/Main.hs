{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.ByteString (ByteString)
import qualified Data.ByteString as B
import qualified Data.ByteString.Internal as B
import Debug.Trace
import System.IO


eightBytes :: Handle -> IO ()
eightBytes hdl = do
   bs <- B.hGet hdl 8
   printChunk bs
   where
    printChunk :: ByteString -> IO ()
    printChunk bs =
     if B.null bs
     then return ()
     else
     do
      B.hPut stdout bs
      newlines hdl

newlines :: Handle -> IO ()
newlines hdl = go B.empty hdl
   where
      go :: ByteString -> Handle -> IO ()
      go buf h = do
         bs' <- B.hGet h 8
         if B.null bs'
         then do
            B.hPut stdout ("read: " <> buf)
            hClose h
            return ()
         else
            case B.findIndex (== (B.c2w '\n')) buf of
               Just idx -> do
                  let lineLen = idx + 1
                  let line = "read: " <> B.take lineLen buf
                  let rest = B.drop lineLen buf
                  B.hPut stdout line
                  go (rest <> bs') h
               Nothing ->
                  go (buf <> bs') h

main :: IO ()
main = do
    hdl <- openFile "messages.txt" ReadMode
--    eightBytes hdl
    newlines hdl
