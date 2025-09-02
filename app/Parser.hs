module Parser
   ( parseRequest
   ) where

import Data.ByteString.Lazy (ByteString)
import Data.ByteString.Lazy as B

import Http.Request

parseRequest :: ByteString -> Request
parseRequest bs = undefined

