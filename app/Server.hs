module Server (server) where

import Data.ByteString.Lazy (ByteString)
import qualified Data.ByteString.Lazy as Bytes
import qualified Data.ByteString.Lazy.Internal as Bytes
import Network.Socket as Socket
import Network.Socket.ByteString.Lazy as Socket

import Parser (parseRequest)
import Http.Request (Request)
import Http.Response (Response, unpackResponse)

server :: Socket -> IO ()
server sock = do
   bs <- Socket.getContents sock
   response <- handler bs
   sendAll sock response

handler :: ByteString -> IO ByteString
handler bs = do
   let request = parseRequest bs
   response <- handleRequest request
   return $ unpackResponse response

handleRequest :: Request -> IO Response
handleRequest req = undefined
