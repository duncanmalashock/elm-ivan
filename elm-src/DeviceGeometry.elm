module DeviceGeometry exposing (..)

import Vector exposing (Vector2D)


type Point
    = Point Vector2D


type alias LineSegment =
    ( Point, Point )


type alias Object =
    List LineSegment


lineSegmentToInts : LineSegment -> List (List Int)
lineSegmentToInts ( start, end ) =
    let
        ( x1, y1 ) =
            case start of
                Point ( x1, y1 ) ->
                    ( x1, y1 )

        ( x2, y2 ) =
            case end of
                Point ( x2, y2 ) ->
                    ( x2, y2 )
    in
        [ [ truncate x1, truncate y1, 0 ]
        , [ truncate x2, truncate y2, 63 ]
        ]
