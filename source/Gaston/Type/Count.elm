module Gaston.Type.Count exposing (..)

import Json.Decode as Decode
import Json.Encode as Encode
import Maybe.Extra as Maybe


type Count
    = Count Int


zero : Count
zero =
    Count 0


fromInt : Int -> Maybe Count
fromInt int =
    if int < 0 then
        Nothing

    else
        Just (Count int)


toInt : Count -> Int
toInt (Count int) =
    int


fromJson : Decode.Decoder Count
fromJson =
    Decode.int
        |> Decode.andThen
            (\int ->
                int
                    |> fromInt
                    |> Maybe.unwrap (Decode.fail ("invalid count: " ++ String.fromInt int)) Decode.succeed
            )


toJson : Count -> Encode.Value
toJson count =
    count
        |> toInt
        |> Encode.int
