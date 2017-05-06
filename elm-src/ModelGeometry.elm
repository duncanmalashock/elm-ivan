module ModelGeometry exposing (..)

import Vector exposing (Vector3D)


type Point
    = Point Vector3D


type alias LineSegment =
    ( Point, Point )


cube : List LineSegment
cube =
    let
        edgeLength =
            50
    in
        [ ( Point ( -edgeLength, -edgeLength, -edgeLength )
          , Point ( edgeLength, -edgeLength, -edgeLength )
          )
        , ( Point ( edgeLength, -edgeLength, -edgeLength )
          , Point ( edgeLength, edgeLength, -edgeLength )
          )
        , ( Point ( edgeLength, edgeLength, -edgeLength )
          , Point ( -edgeLength, edgeLength, -edgeLength )
          )
        , ( Point ( -edgeLength, edgeLength, -edgeLength )
          , Point ( -edgeLength, -edgeLength, -edgeLength )
          )
        , ( Point ( -edgeLength, -edgeLength, edgeLength )
          , Point ( edgeLength, -edgeLength, edgeLength )
          )
        , ( Point ( edgeLength, -edgeLength, edgeLength )
          , Point ( edgeLength, edgeLength, edgeLength )
          )
        , ( Point ( edgeLength, edgeLength, edgeLength )
          , Point ( -edgeLength, edgeLength, edgeLength )
          )
        , ( Point ( -edgeLength, edgeLength, edgeLength )
          , Point ( -edgeLength, -edgeLength, edgeLength )
          )
        , ( Point ( -edgeLength, -edgeLength, edgeLength )
          , Point ( -edgeLength, -edgeLength, -edgeLength )
          )
        , ( Point ( edgeLength, -edgeLength, edgeLength )
          , Point ( edgeLength, -edgeLength, -edgeLength )
          )
        , ( Point ( edgeLength, edgeLength, edgeLength )
          , Point ( edgeLength, edgeLength, -edgeLength )
          )
        , ( Point ( -edgeLength, edgeLength, edgeLength )
          , Point ( -edgeLength, edgeLength, -edgeLength )
          )
        ]


applyTransform3DFunction :
    (Vector3D -> Vector3D)
    -> List LineSegment
    -> List LineSegment
applyTransform3DFunction transformFunction geometry =
    List.map (applyTransform3DFunctionToLineSegment transformFunction) geometry


applyTransform3DFunctionToLineSegment :
    (Vector3D -> Vector3D)
    -> LineSegment
    -> LineSegment
applyTransform3DFunctionToLineSegment transformFunction ( Point start, Point end ) =
    ( Point <| transformFunction start
    , Point <| transformFunction end
    )
