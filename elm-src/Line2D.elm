module Line2D exposing (..)

import String
import Vector2D exposing (Vector2D)


type alias Line2D =
    { start : Vector2D
    , end : Vector2D
    }


asString : Line2D -> String
asString theLine =
    let
        ( x1, y1 ) =
            theLine.start

        ( x2, y2 ) =
            theLine.end
    in
        String.join " " <| List.map (floor >> toString) [ x1, y1, x2, y2 ]


translate : Vector2D -> Line2D -> Line2D
translate delta theLine =
    { theLine | start = Vector2D.translate delta theLine.start, end = Vector2D.translate delta theLine.end }


scale : Float -> Line2D -> Line2D
scale amount theLine =
    { theLine | start = Vector2D.scale amount theLine.start, end = Vector2D.scale amount theLine.end }


rotateZ : Float -> Line2D -> Line2D
rotateZ theta theLine =
    { theLine | start = Vector2D.rotateZ theta theLine.start, end = Vector2D.rotateZ theta theLine.end }
