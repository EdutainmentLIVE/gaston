module Gaston.Type.Model exposing (..)

import Browser.Navigation as Nav
import Gaston.Type.Flags as Flags
import Time
import Url


type alias Model =
    { flags : Flags.Flags
    , key : Nav.Key
    , posix : Maybe Time.Posix
    , url : Url.Url
    , zone : Maybe Time.Zone
    }
