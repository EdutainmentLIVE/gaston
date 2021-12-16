module Gaston.Type.Message exposing (..)

import Browser
import Time
import Url


type Message
    = Identity
    | PosixChange Time.Posix
    | UrlChange Url.Url
    | UrlRequest Browser.UrlRequest
    | ZoneChange Time.Zone
