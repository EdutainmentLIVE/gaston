module Gaston.Update exposing (update)

import Browser
import Browser.Navigation as Nav
import Gaston.Constant as Constant
import Gaston.LocalStorage as LocalStorage
import Gaston.Type.Count as Count
import Gaston.Type.Exercise as Exercise
import Gaston.Type.Message as Message
import Gaston.Type.Model as Model
import Gaston.Type.Workouts as Workouts
import Json.Decode as Decode
import Json.Encode as Encode
import List.Extra as List
import RemoteData
import Url


update : Message.Message -> Model.Model -> ( Model.Model, Cmd Message.Message )
update message model =
    case message of
        Message.CountChange string ->
            case String.toInt string of
                Just int ->
                    case Count.fromInt int of
                        Just count ->
                            ( { model | count = count }, Cmd.none )

                        Nothing ->
                            ( model, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )

        Message.DeleteWorkout index ->
            case model.workouts of
                RemoteData.Success workouts ->
                    let
                        newWorkouts =
                            List.removeAt index workouts

                        value =
                            Encode.encode 0 (Workouts.toJson newWorkouts)
                    in
                    ( { model | workouts = RemoteData.Success newWorkouts }
                    , LocalStorage.setItem { key = Constant.workoutsKey, value = value }
                    )

                _ ->
                    ( model, Cmd.none )

        Message.ExerciseChange string ->
            case Exercise.fromString string of
                Just exercise ->
                    ( { model | exercise = exercise }, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )

        Message.Identity ->
            ( model, Cmd.none )

        Message.PosixChange posix ->
            ( { model | posix = Just posix }, Cmd.none )

        Message.RemoveItem key ->
            ( model
            , LocalStorage.removeItem key
            )

        Message.ReceiveItem key maybeValue ->
            if key == Constant.workoutsKey then
                case maybeValue of
                    Nothing ->
                        let
                            workouts =
                                []

                            value =
                                Encode.encode 0 (Workouts.toJson workouts)
                        in
                        ( { model | workouts = RemoteData.Success workouts }
                        , LocalStorage.setItem { key = key, value = value }
                        )

                    Just value ->
                        case Decode.decodeString Workouts.fromJson value of
                            Err error ->
                                ( { model | workouts = RemoteData.Failure error }, Cmd.none )

                            Ok workouts ->
                                ( { model | workouts = RemoteData.Success workouts }, Cmd.none )

            else
                ( model, Cmd.none )

        Message.RequestItem key ->
            ( model
            , LocalStorage.requestItem key
            )

        Message.SaveWorkout ->
            case ( model.posix, model.workouts ) of
                ( Just posix, RemoteData.Success workouts ) ->
                    let
                        workout =
                            { count = model.count
                            , exercise = model.exercise
                            , posix = posix
                            }

                        newWorkouts =
                            workout :: workouts

                        value =
                            Encode.encode 0 (Workouts.toJson newWorkouts)
                    in
                    ( { model | workouts = RemoteData.Success newWorkouts }
                    , LocalStorage.setItem { key = Constant.workoutsKey, value = value }
                    )

                _ ->
                    ( model, Cmd.none )

        Message.SetItem key value ->
            ( model
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
