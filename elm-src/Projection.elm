module Projection exposing (..)

import Vector2D exposing (Vector2D)
import Line2D exposing (Line2D)
import Object exposing (Object)
import LineSegment exposing (LineSegment)
import Vector3D exposing (Vector3D)
import Point exposing (Point(..))


projectPoint : Point -> Vector2D
projectPoint point =
    let
        ( povX, povY, povZ ) =
            ( 200, 200, -800 )
    in
        case point of
            InModelSpace ( x, y, z ) ->
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
