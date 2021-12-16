module Gaston.Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Gaston.Type.Flags as Flags
import Gaston.Type.Message as Message
import Gaston.Type.Model as Model
import Gaston.Update as Update
import Gaston.View as View
import Task
import Time
import Url


main : Program Flags.Flags Model.Model Message.Message
main =
    Browser.application
        { init = init
        , view = View.view
        , update = Update.update
        , subscriptions = subscriptions
        , onUrlRequest = Message.UrlRequest
        , onUrlChange = Message.UrlChange
        }


init : Flags.Flags -> Url.Url -> Nav.Key -> ( Model.Model, Cmd Message.Message )
init flags url key =
    let
        model =
            { flags = flags
            , key = key
            , posix = Nothing
            , url = url
            , zone = Nothing
            }

        command =
            Cmd.batch
                [ Task.perform Message.ZoneChange Time.here
                , Task.perform Message.PosixChange Time.now
                , Task.perform identity (Task.succeed Message.Identity)
                ]
    in
    ( model, command )


subscriptions : Model.Model -> Sub Message.Message
subscriptions _ =
    Time.every 1000 Message.PosixChange
