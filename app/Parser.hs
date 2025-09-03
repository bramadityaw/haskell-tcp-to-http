module Parser where

import Data.ByteString.Lazy (LazyByteString)
import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Char8 as Char8
import Data.ByteString.Internal (c2w)

import Http.Request
import Http.Common

data ParseError
   = ParseError
   { func :: String
   , reason :: String
   } deriving Show

type Parser a = LazyByteString -> Either ParseError (a, LazyByteString)

-- Remove leading whitespace
trimStart :: LazyByteString -> LazyByteString
trimStart = B.dropWhile isSpace
   where
      isSpace = (== (c2w ' '))

parseMethod :: Parser Method
parseMethod bs =
   case result of
      Right method -> Right (method, trimStart rest)
      Left err -> Left err
   where
      (m, rest) = B.break ((==) (c2w ' ')) bs
      result :: Either ParseError Method
      result =
         case Char8.unpack $ Char8.toStrict m of
            "OPTIONS" -> Right Options
            "GET" -> Right Get
            "POST" -> Right Post
            "PUT" -> Right Put
            "PATCH" -> Right Patch
            "DELETE" -> Right Delete
            _ -> Left $ ParseError "parseMethod" "unknown method"

parseRequest' :: Parser Request
parseRequest' bs = undefined

parseRequest :: LazyByteString -> Request
parseRequest bs =
   case parseRequest' bs of
      Right (req, _) -> req
      Left _ -> undefined
