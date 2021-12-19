module Gaston.Type.Message exposing (Message(..))

import Browser
import Time
import Url


type Message
    = CountChange String
    | DeleteWorkout Int
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
