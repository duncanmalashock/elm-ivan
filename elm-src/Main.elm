module Main exposing (..)

import Renderables2D.Vector2D as Vector2D exposing (Vector2D)
import Renderables2D.Line2D as Line2D exposing (Line2D)
import Renderables2D.Rect2D as Rect2D exposing (Rect2D)
import Renderables2D.Geometry2D as Geometry2D exposing (Geometry2D)
import Renderables2D.Object2D as Object2D exposing (Object2D)
import Renderables3D.Vector3D as Vector3D exposing (Vector3D)
import Renderables3D.Line3D as Line3D exposing (Line3D)
import Renderables3D.Geometry3D as Geometry3D exposing (Geometry3D)
import Renderables3D.Object3D as Object3D exposing (Object3D)
import Projection
import Readout
import WebVectorDisplay
import CmdHelper exposing (cmdFromMsg)
import Html exposing (Html, text, div)
import Html.App as Html
import Html.Attributes exposing (class)
import Mouse


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
    { objects2D : List Object2D
    , objects3D : List Object3D
    , renderedLines : List Line2D
    , inBoundary : Rect2D
    , outBoundary : Rect2D
    , rotateAmount : Float
    }


init : ( Model, Cmd Msg )
init =
    ( { renderedLines = []
      , objects2D =
            [ Object2D Geometry2D.square ( 170, 100 ) 1.0 0
            , Object2D Geometry2D.square ( 280, 100 ) 0.5 0
            , Object2D Geometry2D.square ( 350, 100 ) 0.25 0
            ]
      , objects3D =
            [ Object3D Geometry3D.cube ( 170, 275, 100 ) 1.0 ( 0, 0, 0 )
            , Object3D Geometry3D.cube ( 280, 275, 100 ) 0.5 ( 0, 0, 0 )
            , Object3D Geometry3D.cube ( 350, 275, 100 ) 0.25 ( 0, 0, 0 )
            ]
      , inBoundary = Rect2D 0 550 0 400
      , outBoundary = Rect2D 0 2048 0 2048
      , rotateAmount = 0.0
      }
    , cmdFromMsg RenderObjects
    )


type Msg
    = NoOp
    | MoveMouse Mouse.Position
    | RenderObjects


renderObjects2D : List Object2D -> List Line2D
renderObjects2D objects2D =
    List.concat (List.map Object2D.render objects2D)


renderObjects3D : List Object3D -> List Line2D
renderObjects3D objects3D =
    List.concat (List.map Projection.projectObject objects3D)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        MoveMouse newMousePosition ->
            let
                theta =
                    toFloat newMousePosition.x / 20
            in
                ( { model
                    | objects2D =
                        List.map
                            (\obj ->
                                { obj
                                    | rotation = theta
                                }
                            )
                            model.objects2D
                    , objects3D =
                        List.map
                            (\obj ->
                                { obj
                                    | rotation =
                                        ( theta
                                        , theta
                                        , theta
                                        )
                                }
                            )
                            model.objects3D
                  }
                , cmdFromMsg RenderObjects
                )

        RenderObjects ->
            ( { model
                | renderedLines =
                    List.concat
                        [ (renderObjects2D model.objects2D)
                        , (renderObjects3D model.objects3D)
                        ]
              }
            , Cmd.none
            )


view : Model -> Html Msg
view model =
    div [ class "app" ]
        [ WebVectorDisplay.view model.renderedLines
        , Readout.view model.inBoundary model.outBoundary model.renderedLines
        ]
