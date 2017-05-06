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


mapObject :
    (Vector3D -> Vector3D)
    -> List LineSegment
    -> List LineSegment
mapObject transform geometry =
    List.map (mapLineSegment transform) geometry


mapPoint : (Vector3D -> Vector3D) -> Point -> Point
mapPoint transform (Point vector) =
    Point <| transform vector


mapLineSegment : (Vector3D -> Vector3D) -> LineSegment -> LineSegment
mapLineSegment transform ( start, end ) =
    ( mapPoint transform start
    , mapPoint transform end
    )
