port module Main exposing (..)

import Renderables2D.Line2D as Line2D exposing (Line2D)
import Renderables2D.Rect2D as Rect2D exposing (Rect2D)
import Renderables3D.Geometry as Geometry exposing (Geometry)
import Renderables3D.Object as Object exposing (Object)
import Renderables3D.Transform as Transform exposing (Transform)
import Projection
import WebVectorDisplay
import Html exposing (Html, text, div, input)
import Html.Attributes exposing (class, min, max, value)
import Html.Events exposing (on, onInput)
import Mouse


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Mouse.moves MoveMouse


type alias Model =
    { objects3D : List Object
    , renderedLines : List Line2D
    , inBoundary : Rect2D
    , outBoundary : Rect2D
    , rotateAmount : Float
    }


init : ( Model, Cmd Msg )
init =
    let
        positionTransform =
            Transform.Translate ( 200, 200, 100 )

        scaleTransform =
            Transform.Scale ( 1.0, 1.0, 1.0 )

        rotationTransform =
            Transform.Rotate ( 0, 0, 0 )

        initialModel =
            { renderedLines = []
            , objects3D =
                [ Object Geometry.cube
                    positionTransform
                    scaleTransform
                    rotationTransform
                ]
            , inBoundary = Rect2D 0 400 0 400
            , outBoundary = Rect2D 0 4095 0 4095
            , rotateAmount = 0.0
            }
    in
        renderObjects initialModel


type Msg
    = MoveMouse Mouse.Position
    | UpdateSlider String


renderObjects3D : List Object -> List Line2D
renderObjects3D objects3D =
    List.concat (List.map Projection.projectObject objects3D)


linesToArraysOfInts : List Line2D -> List (List Int)
linesToArraysOfInts lines =
    List.concat <| List.map Line2D.asInts lines


port sendDrawingInstructions : List (List Int) -> Cmd msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MoveMouse mousePosition ->
            ( model, Cmd.none )

        UpdateSlider newX ->
            let
                thetaX =
                    toFloat (String.toInt newX |> Result.withDefault 0)
            in
                renderObjects
                    { model
                        | objects3D =
                            List.map
                                (\obj ->
                                    { obj
                                        | rotation =
                                            Transform.Rotate
                                                ( 0, thetaX, 0 )
                                    }
                                )
                                model.objects3D
                        , rotateAmount = thetaX
                    }


renderObjects : Model -> ( Model, Cmd Msg )
renderObjects model =
    ( { model
        | renderedLines =
            List.concat
                [ (renderObjects3D model.objects3D)
                ]
      }
    , sendDrawingInstructions <|
        linesToArraysOfInts
            (List.map
                (Rect2D.normalize model.inBoundary model.outBoundary)
                model.renderedLines
            )
    )


view : Model -> Html Msg
view model =
    div [ class "app" ]
        [ WebVectorDisplay.view model.renderedLines
        , div []
            [ input
                [ Html.Attributes.type_ "range"
                , Html.Attributes.min "0"
                , Html.Attributes.max "90"
                , value <| toString model.rotateAmount
                , onInput UpdateSlider
                ]
                []
            ]
        ]
