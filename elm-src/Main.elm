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
    { objects2D : List Object2D
    , objects3D : List Object3D
    , renderedLines : List Line2D
    , inBoundary : Rect2D
    , outBoundary : Rect2D
    }


init : ( Model, Cmd Msg )
init =
    ( { renderedLines = []
      , objects2D =
            [ Object2D Geometry2D.square ( 100, 100 ) 1.0 30
            , Object2D Geometry2D.square ( 120, 100 ) 0.7 50
            , Object2D Geometry2D.square ( 140, 100 ) 0.4 70
            ]
      , objects3D =
            [ Object3D Geometry3D.cube ( 200, 100, 100 ) 1.0 ( 0, 0, 0 )
            , Object3D Geometry3D.cube ( 325, 100, 100 ) 0.5 ( 60, 70, 80 )
            , Object3D Geometry3D.cube ( 400, 100, 100 ) 0.25 ( 20, 30, 40 )
            ]
      , inBoundary = Rect2D 0 550 0 400
      , outBoundary = Rect2D 0 2048 0 2048
      }
    , cmdFromMsg RenderObjects
    )


type Msg
    = NoOp
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
        [ Readout.view model.inBoundary model.outBoundary model.renderedLines
        , WebVectorDisplay.view model.renderedLines
        ]
