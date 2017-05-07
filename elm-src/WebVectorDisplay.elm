module WebVectorDisplay exposing (view)

import ImageGeometry
import Html exposing (Html)
import Svg exposing (Svg, svg, line, g)
import Svg.Attributes exposing (x1, y1, x2, y2, stroke, strokeWidth, transform)


drawLine : ImageGeometry.LineSegment -> Svg msg
drawLine ( start, end ) =
    let
        ( x1_, y1_ ) =
            case start of
                ImageGeometry.Point ( x1__, y1__ ) ->
                    ( x1__, y1__ )

        ( x2_, y2_ ) =
            case end of
                ImageGeometry.Point ( x2__, y2__ ) ->
                    ( x2__, y2__ )
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


view : ImageGeometry.Object -> Html msg
view lines =
    svg
        []
        (List.map drawLine lines)
