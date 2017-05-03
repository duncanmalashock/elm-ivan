module Projection exposing (..)

import Vector2D as Vector2D exposing (Vector2D)
import Line2D as Line2D exposing (Line2D)
import Object as Object exposing (Object)
import LineSegment as LineSegment exposing (LineSegment)
import Vector3D as Vector3D exposing (Vector3D)


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
