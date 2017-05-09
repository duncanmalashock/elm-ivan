module Main exposing (..)

import Pipeline
import ModelGeometry
import ImageGeometry
import ObjectTree exposing (ObjectTree, Id(Id))
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
    { objectTree : ObjectTree
    , rendered : ImageGeometry.Object
    , imageBounds : ImageGeometry.Bounds
    , deviceBounds : ImageGeometry.Bounds
    , rotateAmount : Float
    , scaleAmount : Float
    }


exampleObjectTree : Float -> Float -> ObjectTree
exampleObjectTree scale rotate =
    let
        addStandardTransforms =
            ObjectTree.addTransform (Rotate3D ( 0, rotate, 0 ))
                >> ObjectTree.addTransform (Scale3D ( scale, scale, scale ))

        eyeball1 =
            ModelGeometry.cube
                |> ObjectTree.objectToTree (Id 3)
                |> ObjectTree.addTransform (Translate3D ( 50, 50, 50 ))

        cube1 =
            ModelGeometry.cube
                |> ObjectTree.objectToTree (Id 1)
                |> addStandardTransforms
                |> ObjectTree.addTransform (Translate3D ( 300, 200, -500 ))
                |> ObjectTree.addToGroup eyeball1

        eyeball2 =
            ModelGeometry.cube
                |> ObjectTree.objectToTree (Id 4)
                |> ObjectTree.addTransform (Translate3D ( 50, 50, 50 ))

        cube2 =
            ModelGeometry.cube
                |> ObjectTree.objectToTree (Id 2)
                |> addStandardTransforms
                |> ObjectTree.addTransform (Translate3D ( 100, 200, -500 ))
                |> ObjectTree.addToGroup eyeball2
    in
        ObjectTree.emptyObjectTree
            |> ObjectTree.addToGroup cube1
            |> ObjectTree.addToGroup cube2


init : ( Model, Cmd Msg )
init =
    let
        objectTree =
            exampleObjectTree 1 0

        initialModel =
            { rendered = []
            , objectTree =
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
        | rendered =
            model.objectTree
                |> Pipeline.toSceneObject
                |> Pipeline.toImageObject Pipeline.perspectiveProjection
      }
    , Pipeline.outputToDevice
        model.imageBounds
        model.deviceBounds
        model.rendered
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
                        | objectTree =
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
                        | objectTree =
                            objectTree
                        , rotateAmount = r
                    }


view : Model -> Html Msg
view model =
    div [ class "app" ]
        [ WebVectorDisplay.view model.rendered
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
