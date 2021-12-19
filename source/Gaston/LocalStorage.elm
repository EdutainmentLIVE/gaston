port module Gaston.LocalStorage exposing
    ( receiveItem
    , removeItem
    , requestItem
    , setItem
    )


port receiveItem : ({ key : String, value : Maybe String } -> msg) -> Sub msg


port removeItem : String -> Cmd msg


port requestItem : String -> Cmd msg


port setItem : { key : String, value : String } -> Cmd msg
