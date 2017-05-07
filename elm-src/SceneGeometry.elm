module SceneGeometry
    exposing
        ( Object
        , LineSegment
        , Point(Point)
        )

import Vector exposing (Vector3D)


type Point
    = Point Vector3D


type alias LineSegment =
    ( Point, Point )


type alias Object =
    List LineSegment


mapObject : (Vector3D -> Vector3D) -> Object -> Object
mapObject transform object =
    List.map (mapLineSegment transform) object


mapLineSegment : (Vector3D -> Vector3D) -> LineSegment -> LineSegment
mapLineSegment transform ( start, end ) =
    ( mapPoint transform start
    , mapPoint transform end
    )


mapPoint : (Vector3D -> Vector3D) -> Point -> Point
mapPoint transform (Point vector) =
    Point <| transform vector
