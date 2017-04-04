module WebVectorDisplay exposing (..)

import Renderables2D.Line2D exposing (Line2D)
import Html exposing (Html)
import Svg exposing (Svg, svg, line, g)
import Svg.Attributes exposing (x1, y1, x2, y2, stroke, strokeWidth, transform)


drawLine : Line2D -> Svg msg
drawLine theLine =
    let
        ( x1_, y1_ ) =
            theLine.start

        ( x2_, y2_ ) =
            theLine.end
    in
        g
            []
            [ line
                [ stroke "black"
                , strokeWidth "2"
                , x1 (toString x1_)
                , x2 (toString x2_)
                , y1 (toString <| 400 - y1_)
                , y2 (toString <| 400 - y2_)
                ]
                []
            ]


view : List Line2D -> Html msg
view lines =
    svg
        []
        (List.map drawLine lines)
