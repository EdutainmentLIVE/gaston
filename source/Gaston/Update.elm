module Gaston.Update exposing (..)

import Browser
import Browser.Navigation as Nav
import Dict
import Gaston.LocalStorage as LocalStorage
import Gaston.Type.Message as Message
import Gaston.Type.Model as Model
import RemoteData
import Url


update : Message.Message -> Model.Model -> ( Model.Model, Cmd Message.Message )
update message model =
    case message of
        Message.Identity ->
            ( model, Cmd.none )

        Message.PosixChange posix ->
            ( { model | posix = Just posix }, Cmd.none )

        Message.RemoveItem key ->
            ( { model | items = Dict.remove key model.items }
            , LocalStorage.removeItem key
            )

        Message.ReceiveItem key maybeValue ->
            ( { model | items = Dict.insert key (RemoteData.Success maybeValue) model.items }
            , Cmd.none
            )

        Message.RequestItem key ->
            ( { model | items = Dict.insert key RemoteData.Loading model.items }
            , LocalStorage.requestItem key
            )

        Message.SetItem key value ->
            ( { model | items = Dict.insert key (RemoteData.Success (Just value)) model.items }
            , LocalStorage.setItem { key = key, value = value }
            )

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
