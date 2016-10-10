module Object2D exposing (..)

import Line2D exposing (Line2D)
import Vector2D exposing (Vector2D)


type alias Object2D =
    { geometry : List Line2D
    , position : Vector2D
    , scale : Float
    , rotation : Float
    }


render : Object2D -> List Line2D
render object =
    List.map
        ((Line2D.scale object.scale)
            >> (Line2D.rotateZ object.rotation)
            >> (Line2D.translate object.position)
        )
        object.geometry
