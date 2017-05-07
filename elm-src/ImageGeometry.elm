module ImageGeometry exposing (..)

import Vector exposing (Vector2D)
import Rect2D exposing (Rect2D)


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


normalize : Rect2D -> Rect2D -> Object -> Object
normalize inBoundary outBoundary object =
    let
        yTranslate =
            outBoundary.minY - inBoundary.minY

        yScale =
            (outBoundary.maxY - outBoundary.minY)
                / (inBoundary.maxY - inBoundary.minY)

        xTranslate =
            outBoundary.minX - inBoundary.minX

        xScale =
            (outBoundary.maxX - outBoundary.minX)
                / (inBoundary.maxX - inBoundary.minX)

        xTransform : Float -> Float
        xTransform x =
            (x - inBoundary.minX) * xScale + (inBoundary.minX) + xTranslate

        yTransform : Float -> Float
        yTransform y =
            (y - inBoundary.minY) * yScale + (inBoundary.minY) + yTranslate
    in
        object
            |> mapObject (\( x, y ) -> ( xTransform x, y ))
            |> mapObject (\( x, y ) -> ( x, yTransform y ))
