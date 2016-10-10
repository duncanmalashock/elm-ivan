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
    let
        scaledGeometry =
            (List.map (Line2D.scale object.scale) object.geometry)
    in
        (List.map ((Line2D.translate object.position) << (Line2D.rotateZ object.rotation)) scaledGeometry)
