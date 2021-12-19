module Gaston.Type.Workout exposing
    ( Workout
    , fromJson
    , toJson
    )

import Gaston.Extra.Time as Time
import Gaston.Type.Count as Count
import Gaston.Type.Exercise as Exercise
import Json.Decode as Decode
import Json.Encode as Encode
import Time


type alias Workout =
    { count : Count.Count
    , exercise : Exercise.Exercise
    , posix : Time.Posix
    }


fromJson : Decode.Decoder Workout
fromJson =
    Decode.map3 Workout
        (Decode.field "count" Count.fromJson)
        (Decode.field "exercise" Exercise.fromJson)
        (Decode.field "posix" Time.posixFromJson)


toJson : Workout -> Encode.Value
toJson workout =
    Encode.object
        [ ( "count", Count.toJson workout.count )
        , ( "exercise", Exercise.toJson workout.exercise )
        , ( "posix", Time.posixToJson workout.posix )
        ]
