module Gaston.Type.Exercise exposing
    ( Exercise(..)
    , all
    , fromJson
    , fromString
    , toJson
    , toString
    )

import Json.Decode as Decode
import Json.Encode as Encode
import Maybe.Extra as Maybe


type Exercise
    = BicycleCrunch
    | JumpingJack
    | PullUp
    | PushUp
    | Row
    | Squat


all : List Exercise
all =
    [ BicycleCrunch
    , JumpingJack
    , PullUp
    , PushUp
    , Row
    , Squat
    ]


fromString : String -> Maybe Exercise
fromString string =
    case string of
        "bicycle-crunch" ->
            Just BicycleCrunch

        "jumping-jack" ->
            Just JumpingJack

        "pull-up" ->
            Just PullUp

        "push-up" ->
            Just PushUp

        "row" ->
            Just Row

        "squat" ->
            Just Squat

        _ ->
            Nothing


toString : Exercise -> String
toString exercise =
    case exercise of
        BicycleCrunch ->
            "bicycle-crunch"

        JumpingJack ->
            "jumping-jack"

        PullUp ->
            "pull-up"

        PushUp ->
            "push-up"

        Row ->
            "row"

        Squat ->
            "squat"


fromJson : Decode.Decoder Exercise
fromJson =
    Decode.string
        |> Decode.andThen
            (\string ->
                string
                    |> fromString
                    |> Maybe.unwrap (Decode.fail ("invalid exercise: " ++ string)) Decode.succeed
            )


toJson : Exercise -> Encode.Value
toJson exercise =
    exercise
        |> toString
        |> Encode.string
