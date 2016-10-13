module Readout exposing (..)

import Renderables2D.Line2D as Line2D exposing (Line2D)
import Renderables2D.Rect2D as Rect2D exposing (Rect2D)
import Html exposing (Html, text, div)
import Html.Attributes exposing (class)


lineView : Line2D -> Html msg
lineView theline =
    div [] [ text <| Line2D.asString theline ]


lineGroupView : String -> List Line2D -> Html msg
lineGroupView label lines =
    div []
        [ div [] [ text label ]
        , div [ class "line-list" ]
            (List.map
                lineView
                lines
            )
        ]


view : Rect2D -> Rect2D -> List Line2D -> Html msg
view inBoundary outBoundary lines =
    div [ class "readout" ]
        [ lineGroupView "Lines in scene:" lines
        , lineGroupView "Normalized for scope:" (List.map (Rect2D.normalize inBoundary outBoundary) lines)
        ]
