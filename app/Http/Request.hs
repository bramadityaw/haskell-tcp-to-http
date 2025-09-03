module Http.Request
   ( Request(..)
   , RequestLine(..)
   , Method(..)
   ) where

import Http.Common

data Request = Request RequestLine Message

data Method
   = Options
   | Get
   | Post
   | Put
   | Patch
   | Delete

data RequestLine
   = RequestLine
   { method :: Method
   , path   :: Target
   , version :: Version
   }

data Target
   = Origin FilePath
   | Asterisk
