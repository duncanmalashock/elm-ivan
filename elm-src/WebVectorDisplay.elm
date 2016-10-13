module WebVectorDisplay exposing (..)

import Renderables2D.Line2D exposing (Line2D)
import Html exposing (Html)
import Html.App as Html
import Svg exposing (Svg, svg, line)
import Svg.Attributes exposing (x1, y1, x2, y2, stroke, strokeWidth)


drawLine : Line2D -> Svg msg
drawLine theLine =
    let
        ( x1', y1' ) =
            theLine.start

        ( x2', y2' ) =
            theLine.end
    in
        line
            [ stroke "black"
            , strokeWidth "2"
            , x1 (toString x1')
            , x2 (toString x2')
            , y1 (toString y1')
            , y2 (toString y2')
            ]
            []


view : List Line2D -> Html msg
view lines =
    svg
        []
        (List.map drawLine lines)
