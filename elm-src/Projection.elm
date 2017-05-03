module Projection exposing (..)

import Renderables2D.Vector2D as Vector2D exposing (Vector2D)
import Renderables2D.Line2D as Line2D exposing (Line2D)
import Renderables3D.Object as Object exposing (Object)
import Renderables3D.LineSegment as LineSegment exposing (LineSegment)
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


projectLine : LineSegment -> Line2D
projectLine ( start, end ) =
    ( projectPoint start
    , projectPoint end
    )


projectObject : Object -> List Line2D
projectObject object =
    List.map projectLine (Object.render object)
