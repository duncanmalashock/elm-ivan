module ImageGeometry
    exposing
        ( Object
        , LineSegment
        , Point(Point)
        , Bounds
        , normalize
        )

import Vector exposing (Vector2D)


type Point
    = Point Vector2D


type alias LineSegment =
    ( Point, Point )


type alias Object =
    List LineSegment


type alias Bounds =
    { minX : Float
    , maxX : Float
    , minY : Float
    , maxY : Float
    }


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


normalize : Bounds -> Bounds -> Object -> Object
normalize imageBounds deviceBounds object =
    let
        yTranslate =
            deviceBounds.minY - imageBounds.minY

        yScale =
            (deviceBounds.maxY - deviceBounds.minY)
                / (imageBounds.maxY - imageBounds.minY)

        xTranslate =
            deviceBounds.minX - imageBounds.minX

        xScale =
            (deviceBounds.maxX - deviceBounds.minX)
                / (imageBounds.maxX - imageBounds.minX)

        xTransform : Float -> Float
        xTransform x =
            (x - imageBounds.minX) * xScale + (imageBounds.minX) + xTranslate

        yTransform : Float -> Float
        yTransform y =
            (y - imageBounds.minY) * yScale + (imageBounds.minY) + yTranslate
    in
        object
            |> mapObject (\( x, y ) -> ( xTransform x, y ))
            |> mapObject (\( x, y ) -> ( x, yTransform y ))
