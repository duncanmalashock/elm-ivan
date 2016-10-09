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
        String.join " " (List.map toString [ x1, y1, x2, y2 ])
