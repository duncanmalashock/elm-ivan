module Line2D exposing (..)

import Vector2D exposing (Vector2D)


type alias Line2D =
    { start : Vector2D
    , end : Vector2D
    }


asString : Line2D -> String
asString theLine =
    (toString theLine.start) ++ (toString theLine.end)
