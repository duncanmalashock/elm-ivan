port module Main exposing (..)

import Pipeline
import Rect2D exposing (Rect2D)
import ModelGeometry
import SceneGeometry
import ImageGeometry
import ObjectTree exposing (ObjectTree(..), emptyObjectTree)
import Transform exposing (Transform3D(..))
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
    Sub.none


type alias Model =
    { objects3D : ObjectTree
    , renderedLines : ImageGeometry.Object
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
                |> ObjectTree.addTransform (Scale3D ( 0.7, 0.7, 0.7 ))
                |> ObjectTree.addTransform (Translate3D ( 10, 10, 10 ))
    in
        ObjectTree.addSibling cube2 cube2
            |> ObjectTree.addSibling cube2
            |> ObjectTree.addSibling cube1


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
    = UpdateScaleSlider String
    | UpdateRotateSlider String


renderObjects : Model -> ( Model, Cmd Msg )
renderObjects model =
    let
        newRenderedLines =
            model.objects3D
                |> ObjectTree.toObjects
                |> List.concat
                |> Pipeline.toSceneObject
                |> Pipeline.toImageObject Pipeline.perspectiveProjection
    in
        ( { model
            | renderedLines =
                newRenderedLines
          }
        , newRenderedLines
            |> Rect2D.normalize model.sceneBounds model.displayBounds
            |> List.map ImageGeometry.lineSegmentToInts
            |> List.concat
            |> sendDrawingInstructions
        )


port sendDrawingInstructions : List (List Int) -> Cmd msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
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
