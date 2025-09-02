module Http.Response 
   ( Response
   , unpackResponse
   ) where

import Data.ByteString.Lazy (ByteString)

import Http.Common

type Status = Int

type StatusLine = (Status, Version)

data Response = Response StatusLine Message

unpackResponse :: Response -> ByteString
unpackResponse res = undefined
