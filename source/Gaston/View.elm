module Gaston.View exposing (..)

import Browser
import Gaston.Extra.Time as Time
import Gaston.Type.Count as Count
import Gaston.Type.Exercise as Exercise
import Gaston.Type.Message as Message
import Gaston.Type.Model as Model
import Html
import Html.Attributes as Attr
import Html.Events as Attr
import Json.Decode as Decode
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
                [ Html.h2 [] [ Html.text "Workouts" ]
                , Html.form [ Attr.onSubmit Message.SaveWorkout ]
                    [ Html.div [ Attr.class "mb-3" ]
                        [ Html.label
                            [ Attr.class "form-label"
                            , Attr.for "exercise"
                            ]
                            [ Html.text "Exercise" ]
                        , Html.select
                            [ Attr.class "form-select"
                            , Attr.id "exercise"
                            , Attr.onInput Message.ExerciseChange
                            ]
                          <|
                            List.map
                                (\exercise -> Html.option [] [ Html.text (Exercise.toString exercise) ])
                                Exercise.all
                        ]
                    , Html.div [ Attr.class "mb-3" ]
                        [ Html.label
                            [ Attr.class "form-label"
                            , Attr.for "count"
                            ]
                            [ Html.text "Count" ]
                        , Html.input
                            [ Attr.class "form-control"
                            , Attr.id "count"
                            , Attr.min "0"
                            , Attr.onInput Message.CountChange
                            , Attr.type_ "number"
                            , Attr.value (String.fromInt (Count.toInt model.count))
                            ]
                            []
                        ]
                    , Html.button [ Attr.class "btn btn-primary", Attr.type_ "submit" ]
                        [ Html.text "Save Workout"
                        ]
                    ]
                , case model.workouts of
                    RemoteData.NotAsked ->
                        Html.text "NotAsked"

                    RemoteData.Loading ->
                        Html.text "Loading ..."

                    RemoteData.Failure error ->
                        Html.text ("Failure: " ++ Decode.errorToString error)

                    RemoteData.Success workouts ->
                        Html.ul [ Attr.class "mt-3" ] <|
                            List.map
                                (\workout ->
                                    Html.li []
                                        [ Html.text <|
                                            case model.zone of
                                                Just zone ->
                                                    Time.zonedPosixToString zone workout.posix

                                                Nothing ->
                                                    Time.posixToString workout.posix
                                        , Html.text ": "
                                        , Html.text (String.fromInt (Count.toInt workout.count))
                                        , Html.text " "
                                        , Html.text (Exercise.toString workout.exercise)
                                        ]
                                )
                                workouts
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
