module Gaston.View exposing (..)

import Browser
import Dict
import Gaston.Extra.Time as Time
import Gaston.Type.Message as Message
import Gaston.Type.Model as Model
import Html
import Html.Attributes as Attr
import Html.Events as Attr
import RemoteData


view : Model.Model -> Browser.Document Message.Message
view model =
    { title = "Gaston"
    , body =
        [ Html.div [ Attr.class "navbar navbar-dark bg-dark" ]
            [ Html.div [ Attr.class "container" ]
                [ Html.a [ Attr.class "navbar-brand", Attr.href "/" ]
                    [ Html.text "Gaston"
                    ]
                ]
            ]
        , Html.div [ Attr.class "container" ]
            [ Html.div [ Attr.class "my-3" ]
                [ Html.text "Value:"
                , Html.text <|
                    case Dict.get "hello" model.items of
                        Nothing ->
                            "Nothing"

                        Just remoteData ->
                            case remoteData of
                                RemoteData.NotAsked ->
                                    "Just NotAsked"

                                RemoteData.Loading ->
                                    "Just Loading"

                                RemoteData.Failure _ ->
                                    "Just (Failure _)"

                                RemoteData.Success maybeString ->
                                    case maybeString of
                                        Nothing ->
                                            "Just (Success Nothing)"

                                        Just string ->
                                            "Just (Success (Just " ++ string ++ "))"
                , Html.button [ Attr.onClick (Message.SetItem "hello" "world") ]
                    [ Html.text "set"
                    ]
                , Html.button [ Attr.onClick (Message.RequestItem "hello") ]
                    [ Html.text "get"
                    ]
                , Html.button [ Attr.onClick (Message.RemoveItem "hello") ]
                    [ Html.text "remove"
                    ]
                ]
            , Html.div [ Attr.class "border-top my-3 pt-3 text-center text-muted" ]
                [ Html.text <|
                    case ( model.zone, model.posix ) of
                        ( Just zone, Just posix ) ->
                            Time.zonedPosixToString zone posix

                        ( Nothing, Just posix ) ->
                            Time.posixToString posix

                        _ ->
                            "Does anybody really know what time it is?"
                ]
            ]
        ]
    }
