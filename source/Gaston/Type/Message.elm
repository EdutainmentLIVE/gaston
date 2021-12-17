module Gaston.Type.Message exposing (..)

import Browser
import Time
import Url


type Message
    = Identity
    | PosixChange Time.Posix
    | ReceiveItem String (Maybe String)
    | RemoveItem String
    | RequestItem String
    | SetItem String String
    | UrlChange Url.Url
    | UrlRequest Browser.UrlRequest
    | ZoneChange Time.Zone
