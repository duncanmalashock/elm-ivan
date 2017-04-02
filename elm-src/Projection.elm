module Projection exposing (..)

import Renderables2D.Vector2D as Vector2D exposing (Vector2D)
import Renderables2D.Line2D as Line2D exposing (Line2D)
import Renderables3D.Object3D as Object3D exposing (Object3D)
import Renderables3D.Line3D as Line3D exposing (Line3D)
import Renderables3D.Vector3D as Vector3D exposing (Vector3D)


projectPoint : Vector3D -> Vector2D
projectPoint point =
    let
        ( povX, povY, povZ ) =
            ( 200, 200, -800 )

        ( x, y, z ) =
            point
    in
        ( (povZ * (x - povX) / (z + povZ) + povX)
        , (povZ * (y - povY) / (z + povZ) + povY)
        )


projectLine : Line3D -> Line2D
projectLine line =
    { start = projectPoint line.start
    , end = projectPoint line.end
    }


projectObject : Object3D -> List Line2D
projectObject object =
    List.map projectLine (Object3D.render object)
