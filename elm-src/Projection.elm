module Projection exposing (..)

import Vector exposing (Vector3D, Vector2D)
import Line2D exposing (Line2D)
import Object exposing (Object)
import ModelGeometry
import Point exposing (ModelPoint(..))


projectCoordinates : Vector3D -> Vector2D
projectCoordinates ( x, y, z ) =
    let
        ( povX, povY, povZ ) =
            ( 200, 200, -800 )
    in
        ( (povZ * (x - povX) / (z + povZ) + povX)
        , (povZ * (y - povY) / (z + povZ) + povY)
        )


projectLine : ModelGeometry.LineSegment -> Line2D
projectLine ( ModelPoint start, ModelPoint end ) =
    ( projectCoordinates start
    , projectCoordinates end
    )
