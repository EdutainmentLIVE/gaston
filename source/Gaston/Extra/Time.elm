module Gaston.Extra.Time exposing (..)

import Time


monthToInt : Time.Month -> Int
monthToInt month =
    case month of
        Time.Jan ->
            1

        Time.Feb ->
            2

        Time.Mar ->
            3

        Time.Apr ->
            4

        Time.May ->
            5

        Time.Jun ->
            6

        Time.Jul ->
            7

        Time.Aug ->
            8

        Time.Sep ->
            9

        Time.Oct ->
            10

        Time.Nov ->
            11

        Time.Dec ->
            12


millisToSeconds : Int -> Int
millisToSeconds millis =
    millis // 1000


posixToString : Time.Posix -> String
posixToString posix =
    posix
        |> Time.posixToMillis
        |> millisToSeconds
        |> String.fromInt


zonedPosixToString : Time.Zone -> Time.Posix -> String
zonedPosixToString zone posix =
    String.join " "
        [ String.join "-"
            [ String.padLeft 4 '0' <| String.fromInt <| Time.toYear zone posix
            , String.padLeft 2 '0' <| String.fromInt <| monthToInt <| Time.toMonth zone posix
            , String.padLeft 2 '0' <| String.fromInt <| Time.toDay zone posix
            ]
        , String.join ":"
            [ String.padLeft 2 '0' <| String.fromInt <| Time.toHour zone posix
            , String.padLeft 2 '0' <| String.fromInt <| Time.toMinute zone posix
            , String.padLeft 2 '0' <| String.fromInt <| Time.toSecond zone posix
            ]
        ]
