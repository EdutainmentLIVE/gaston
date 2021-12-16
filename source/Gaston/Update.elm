module Gaston.Update exposing (..)

import Browser
import Browser.Navigation as Nav
import Gaston.Type.Message as Message
import Gaston.Type.Model as Model
import Url


update : Message.Message -> Model.Model -> ( Model.Model, Cmd Message.Message )
update message model =
    case message of
        Message.Identity ->
            ( model, Cmd.none )

        Message.PosixChange posix ->
            ( { model | posix = Just posix }, Cmd.none )

        Message.UrlRequest urlRequest ->
            case urlRequest of
                Browser.External string ->
                    ( model, Nav.load string )

                Browser.Internal url ->
                    ( { model | url = url }, Nav.pushUrl model.key (Url.toString url) )

        Message.UrlChange url ->
            ( { model | url = url }, Cmd.none )

        Message.ZoneChange zone ->
            ( { model | zone = Just zone }, Cmd.none )
