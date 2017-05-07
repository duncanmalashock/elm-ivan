module ImageGeometry exposing (..)

import Vector exposing (Vector2D)


type Point
    = Point Vector2D


type alias LineSegment =
    ( Point, Point )


type alias Object =
    List LineSegment


mapObject : (Vector2D -> Vector2D) -> Object -> Object
mapObject transform object =
    List.map (mapLineSegment transform) object


mapLineSegment : (Vector2D -> Vector2D) -> LineSegment -> LineSegment
mapLineSegment transform ( start, end ) =
    ( mapPoint transform start
    , mapPoint transform end
    )


mapPoint : (Vector2D -> Vector2D) -> Point -> Point
mapPoint transform (Point vector) =
    Point <| transform vector
