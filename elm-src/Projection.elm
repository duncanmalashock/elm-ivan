module Projection exposing (..)

import Vector exposing (Vector3D, Vector2D)
import Line2D exposing (Line2D)
import Object exposing (Object)
import Geometry exposing (LineSegment)
import Point exposing (Point(..))


projectCoordinates : Vector3D -> Vector2D
projectCoordinates ( x, y, z ) =
    let
        ( povX, povY, povZ ) =
            ( 200, 200, -800 )
    in
        ( (povZ * (x - povX) / (z + povZ) + povX)
        , (povZ * (y - povY) / (z + povZ) + povY)
        )


projectLine : LineSegment -> Result String Line2D
projectLine lineSegment =
    case lineSegment of
        ( InModelSpace start, InModelSpace end ) ->
            Ok <|
                ( projectCoordinates start
                , projectCoordinates end
                )

        _ ->
            Err <| "Couldn't apply 3D transform to " ++ (toString lineSegment)
