{-# LANGUAGE OverloadedStrings #-}

module Main where

import Network.Run.TCP (runTCPServer)

import Server (server)

main :: IO ()
main = do
   runTCPServer (Just "127.0.0.1") "8000" server
