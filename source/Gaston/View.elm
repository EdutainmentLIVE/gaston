module Gaston.View exposing (..)

import Browser
import Gaston.Extra.Time as Time
import Gaston.Type.Message as Message
import Gaston.Type.Model as Model
import Html


view : Model.Model -> Browser.Document Message.Message
view model =
    { title = "Gaston"
    , body =
        [ Html.h1 [] [Html.text "Gaston"]
        , Html.p []
            [ Html.text <| case (model.zone, model.posix) of
                (Just zone, Just posix) -> Time.zonedPosixToString zone posix
                (Nothing, Just posix) -> Time.posixToString posix
                _ -> "unknown"
            ]
        ]
    }
