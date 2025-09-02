{-# LANGUAGE BangPatterns #-}

module Http.Common where

import Data.ByteString (ByteString)
import Data.Map (Map)
import Data.Text (Text)

type Version = (Int, Int)

data Message
   = Message
   { headers :: Map Text Text
   , body :: !ByteString
   }
