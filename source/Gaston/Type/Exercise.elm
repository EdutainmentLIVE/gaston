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
    | PushUp
    | Squat


all : List Exercise
all =
    [ BicycleCrunch
    , JumpingJack
    , PushUp
    , Squat
    ]


fromString : String -> Maybe Exercise
fromString string =
    case string of
        "bicycle-crunch" ->
            Just BicycleCrunch

        "jumping-jack" ->
            Just JumpingJack

        "push-up" ->
            Just PushUp

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

        PushUp ->
            "push-up"

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
