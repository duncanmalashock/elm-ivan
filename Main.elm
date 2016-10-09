module Main exposing (..)

import Vector2D exposing (Vector2D)
import Line2D exposing (Line2D)
import Rect2D exposing (Rect2D)
import Object2D exposing (Object2D)
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
    { objects : List Object2D
    , renderedLines : List Line2D
    , inBoundary : Rect2D
    , outBoundary : Rect2D
    }


init : ( Model, Cmd Msg )
init =
    let
        bigX =
            { geometry =
                [ Line2D ( 0, 0 ) ( 550, 400 )
                , Line2D ( 550, 0 ) ( 0, 400 )
                ]
            }
    in
        ( { renderedLines = []
          , objects = [ bigX ]
          , inBoundary = Rect2D 0 550 0 400
          , outBoundary = Rect2D 0 2048 0 2048
          }
        , cmdFromMsg RenderObjects
        )


type Msg
    = NoOp
    | RenderObjects


renderObjects : List Object2D -> List Line2D
renderObjects objects =
    List.concat (List.map .geometry objects)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        RenderObjects ->
            ( { model | renderedLines = renderObjects model.objects }, Cmd.none )


view : Model -> Html Msg
view model =
    div [ class "app" ]
        [ Readout.view model.inBoundary model.outBoundary model.renderedLines
        , WebVectorDisplay.view model.renderedLines
        ]
