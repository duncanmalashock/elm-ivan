port module Main exposing (..)

import Line2D exposing (Line2D)
import Rect2D exposing (Rect2D)
import ModelGeometry
import ObjectTree exposing (ObjectTree(..), emptyObjectTree)
import Transform exposing (Transform3D(..))
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
    { objects3D : ObjectTree
    , renderedLines : List Line2D
    , sceneBounds : Rect2D
    , displayBounds : Rect2D
    , rotateAmount : Float
    , scaleAmount : Float
    }


exampleObjectTree : Float -> Float -> ObjectTree
exampleObjectTree scale rotate =
    let
        cube1 =
            ObjectTree.objectToTree ModelGeometry.cube
                |> ObjectTree.addTransform (Rotate3D ( 0, rotate, 0 ))
                |> ObjectTree.addTransform (Scale3D ( scale, scale, scale ))
                |> ObjectTree.addTransform (Translate3D ( 200, 200, 50 ))

        cube2 =
            ObjectTree.objectToTree ModelGeometry.cube
                |> ObjectTree.addTransform (Scale3D ( 0.4, 0.4, 0.4 ))
                |> ObjectTree.addTransform (Translate3D ( 50, 50, 50 ))
    in
        ObjectTree.addSibling cube1 cube2



-- xexampleObjectTree : Float -> Float -> ObjectTree
-- xexampleObjectTree scale rotate =
--     Object.objectTreeFromObject
--         { geometry = []
--         , transforms = []
--         , children =
--             [ Object.objectTreeFromObject
--                 { geometry = ModelGeometry.cube
--                 , transforms =
--                     [ Transform.Translate3D ( 200, 200, 50 )
--                     , Transform.Scale3D ( scale, scale, scale )
--                     , Transform.Rotate3D ( 0, rotate, 0 )
--                     ]
--                 , children =
--                     [ Object.objectTreeFromObject
--                         { geometry = ModelGeometry.cube
--                         , transforms =
--                             [ Transform.Scale3D ( 0.4, 0.4, 0.4 )
--                             , Transform.Translate3D ( 50, 50, 50 )
--                             ]
--                         , children =
--                             [ Object.objectTreeFromObject
--                                 { geometry = ModelGeometry.cube
--                                 , transforms =
--                                     [ Transform.Scale3D ( 0.4, 0.4, 0.4 )
--                                     , Transform.Translate3D ( 50, 50, 50 )
--                                     ]
--                                 , children = []
--                                 }
--                             ]
--                         }
--                     ]
--                 }
--             ]
--         }


init : ( Model, Cmd Msg )
init =
    let
        objectTree =
            exampleObjectTree 1.0 0

        initialModel =
            { renderedLines = []
            , objects3D =
                objectTree
            , sceneBounds = Rect2D 0 400 0 400
            , displayBounds = Rect2D 0 4095 0 4095
            , rotateAmount = 0.0
            , scaleAmount = 1.0
            }
    in
        renderObjects initialModel


type Msg
    = MoveMouse Mouse.Position
    | UpdateScaleSlider String
    | UpdateRotateSlider String


renderObjects3D : ObjectTree -> List Line2D
renderObjects3D objects3D =
    let
        renderedSegments =
            ObjectTree.render objects3D
                |> List.concat
    in
        (List.map Projection.projectLine renderedSegments)


linesToArraysOfInts : List Line2D -> List (List Int)
linesToArraysOfInts lines =
    List.concat <| List.map Line2D.asInts lines


port sendDrawingInstructions : List (List Int) -> Cmd msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MoveMouse mousePosition ->
            ( model, Cmd.none )

        UpdateScaleSlider newVal ->
            let
                s =
                    toFloat (String.toInt newVal |> Result.withDefault 0)

                objectTree =
                    exampleObjectTree ((s / 25.0) + 0.2) model.rotateAmount
            in
                renderObjects
                    { model
                        | objects3D =
                            objectTree
                        , scaleAmount = s
                    }

        UpdateRotateSlider newVal ->
            let
                r =
                    toFloat (String.toInt newVal |> Result.withDefault 0)

                objectTree =
                    exampleObjectTree ((model.scaleAmount / 25.0) + 0.2) r
            in
                renderObjects
                    { model
                        | objects3D =
                            objectTree
                        , rotateAmount = r
                    }


renderObjects : Model -> ( Model, Cmd Msg )
renderObjects model =
    let
        newRenderedLines =
            List.concat [ (renderObjects3D model.objects3D) ]
    in
        ( { model
            | renderedLines =
                newRenderedLines
          }
        , sendDrawingInstructions <|
            linesToArraysOfInts
                (List.map
                    (Rect2D.normalize model.sceneBounds model.displayBounds)
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
                , Html.Attributes.max "100"
                , value <| toString model.scaleAmount
                , onInput UpdateScaleSlider
                ]
                []
            ]
        , div []
            [ input
                [ Html.Attributes.type_ "range"
                , Html.Attributes.min "0"
                , Html.Attributes.max "90"
                , value <| toString model.rotateAmount
                , onInput UpdateRotateSlider
                ]
                []
            ]
        ]
