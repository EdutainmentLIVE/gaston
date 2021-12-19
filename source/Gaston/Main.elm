module Gaston.Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Gaston.Constant as Constant
import Gaston.LocalStorage as LocalStorage
import Gaston.Type.Count as Count
import Gaston.Type.Exercise as Exercise
import Gaston.Type.Flags as Flags
import Gaston.Type.Message as Message
import Gaston.Type.Model as Model
import Gaston.Update as Update
import Gaston.View as View
import RemoteData
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
            { count = Count.zero
            , exercise = Exercise.PushUp
            , flags = flags
            , key = key
            , posix = Nothing
            , url = url
            , workouts = RemoteData.Loading
            , zone = Nothing
            }

        command =
            Cmd.batch
                [ LocalStorage.requestItem Constant.workoutsKey
                , Task.perform Message.ZoneChange Time.here
                , Task.perform Message.PosixChange Time.now
                , Task.perform identity (Task.succeed Message.Identity)
                ]
    in
    ( model, command )


subscriptions : Model.Model -> Sub Message.Message
subscriptions _ =
    Sub.batch
        [ Time.every 1000 Message.PosixChange
        , LocalStorage.receiveItem (\item -> Message.ReceiveItem item.key item.value)
        ]
