module Gaston.Type.Model exposing (..)

import Browser.Navigation as Nav
import Dict
import Gaston.Type.Flags as Flags
import RemoteData
import Time
import Url


type alias Model =
    { flags : Flags.Flags
    , items : Dict.Dict String (RemoteData.RemoteData Never (Maybe String))
    , key : Nav.Key
    , posix : Maybe Time.Posix
    , url : Url.Url
    , zone : Maybe Time.Zone
    }
