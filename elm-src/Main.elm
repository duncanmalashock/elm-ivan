module Main exposing (..)

import Pipeline
import ModelGeometry
import SceneGeometry
import ImageGeometry
import DeviceGeometry
import ObjectTree exposing (ObjectTree(..), emptyObjectTree)
import Transform exposing (Transform3D(..))
import WebVectorDisplay
import Html exposing (Html, text, div, input)
import Html.Attributes exposing (class, min, max, value)
import Html.Events exposing (on, onInput)


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
    , imageBounds : ImageGeometry.Bounds
    , deviceBounds : ImageGeometry.Bounds
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
            , imageBounds = ImageGeometry.Bounds 0 400 0 400
            , deviceBounds = ImageGeometry.Bounds 0 4095 0 4095
            , rotateAmount = 0.0
            , scaleAmount = 1.0
            }
    in
        render initialModel


type Msg
    = UpdateScaleSlider String
    | UpdateRotateSlider String


render : Model -> ( Model, Cmd Msg )
render model =
    ( { model
        | renderedLines =
            model.objects3D
                |> Pipeline.toSceneObject
                |> Pipeline.toImageObject Pipeline.perspectiveProjection
      }
    , Pipeline.outputToDevice
        model.imageBounds
        model.deviceBounds
        model.renderedLines
    )


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
                render
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
                render
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
