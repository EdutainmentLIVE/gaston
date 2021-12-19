module Gaston.Type.Model exposing (Model)

import Browser.Navigation as Nav
import Gaston.Type.Count as Count
import Gaston.Type.Exercise as Exercise
import Gaston.Type.Flags as Flags
import Gaston.Type.Workouts as Workouts
import Json.Decode as Decode
import RemoteData
import Time
import Url


type alias Model =
    { count : Count.Count
    , exercise : Exercise.Exercise
    , flags : Flags.Flags
    , key : Nav.Key
    , posix : Maybe Time.Posix
    , url : Url.Url
    , workouts : RemoteData.RemoteData Decode.Error Workouts.Workouts
    , zone : Maybe Time.Zone
    }
