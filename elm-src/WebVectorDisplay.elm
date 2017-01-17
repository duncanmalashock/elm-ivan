module WebVectorDisplay exposing (..)

import Renderables2D.Line2D exposing (Line2D)
import Html exposing (Html)
import Svg exposing (Svg, svg, line)
import Svg.Attributes exposing (x1, y1, x2, y2, stroke, strokeWidth)


drawLine : Line2D -> Svg msg
drawLine theLine =
    let
        ( x1_, y1_ ) =
            theLine.start

        ( x2_, y2_ ) =
            theLine.end
    in
        line
            [ stroke "black"
            , strokeWidth "2"
            , x1 (toString x1_)
            , x2 (toString x2_)
            , y1 (toString y1_)
            , y2 (toString y2_)
            ]
            []


view : List Line2D -> Html msg
view lines =
    svg
        []
        (List.map drawLine lines)
