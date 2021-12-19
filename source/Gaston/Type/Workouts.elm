module Gaston.Type.Workouts exposing
    ( Workouts
    , fromJson
    , toJson
    )

import Gaston.Type.Workout as Workout
import Json.Decode as Decode
import Json.Encode as Encode


type alias Workouts =
    List Workout.Workout


fromJson : Decode.Decoder Workouts
fromJson =
    Decode.list Workout.fromJson


toJson : Workouts -> Encode.Value
toJson =
    Encode.list Workout.toJson
