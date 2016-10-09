module Main exposing (..)

import Vector2D
import Line2D exposing (Line2D)
import Rect2D exposing (Rect2D)
import WebDisplay
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
    { lines : List Line2D
    , inBoundary : Rect2D
    , outBoundary : Rect2D
    }


init : ( Model, Cmd Msg )
init =
    ( { lines =
            [ Line2D ( 0, 0 ) ( 550, 400 )
            , Line2D ( 550, 0 ) ( 0, 400 )
            ]
      , inBoundary = Rect2D 0 550 0 400
      , outBoundary = Rect2D 0 2048 0 2048
      }
    , Cmd.none
    )


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


lineView : Line2D -> Html Msg
lineView theline =
    div [] [ text <| Line2D.asString theline ]


lineTextView : List Line2D -> Html Msg
lineTextView lines =
    div [ class "readout" ]
        [ div [ class "vertex-list" ]
            (List.map
                lineView
                lines
            )
        ]


view : Model -> Html Msg
view model =
    div [ class "app" ]
        [ lineTextView model.lines
        , WebDisplay.view model.lines
        ]
