module Gaston.Type.Message exposing (..)

import Browser
import Time
import Url


type Message
    = CountChange String
    | ExerciseChange String
    | Identity
    | PosixChange Time.Posix
    | ReceiveItem String (Maybe String)
    | RemoveItem String
    | RequestItem String
    | SaveWorkout
    | SetItem String String
    | UrlChange Url.Url
    | UrlRequest Browser.UrlRequest
    | ZoneChange Time.Zone
