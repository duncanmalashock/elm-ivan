module Projection exposing (..)

import Renderables2D.Line2D as Line2D exposing (Line2D)
import Renderables3D.Object3D as Object3D exposing (Object3D)
import Renderables3D.Line3D as Line3D exposing (Line3D)


projectLine : Line3D -> Line2D
projectLine line =
    let
        ( x1, y1, z1 ) =
            line.start

        ( x2, y2, z2 ) =
            line.end

        zScale =
            0.4
    in
        { start = ( x1 + z1 * zScale, y1 + z1 * zScale )
        , end = ( x2 + z2 * zScale, y2 + z2 * zScale )
        }


projectObject : Object3D -> List Line2D
projectObject object =
    List.map projectLine (Object3D.render object)
