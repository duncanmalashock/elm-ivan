module Rect2D exposing (..)

import ImageGeometry


type alias Rect2D =
    { minX : Float
    , maxX : Float
    , minY : Float
    , maxY : Float
    }


normalize : Rect2D -> Rect2D -> ImageGeometry.Object -> ImageGeometry.Object
normalize inBoundary outBoundary object =
    let
        yTranslate =
            outBoundary.minY - inBoundary.minY

        yScale =
            (outBoundary.maxY - outBoundary.minY) / (inBoundary.maxY - inBoundary.minY)

        xTranslate =
            outBoundary.minX - inBoundary.minX

        xScale =
            (outBoundary.maxX - outBoundary.minX) / (inBoundary.maxX - inBoundary.minX)

        xTransform : Float -> Float
        xTransform x =
            (x - inBoundary.minX) * xScale + (inBoundary.minX) + xTranslate

        yTransform : Float -> Float
        yTransform y =
            (y - inBoundary.minY) * yScale + (inBoundary.minY) + yTranslate
    in
        object
            |> ImageGeometry.mapObject (\( x, y ) -> ( xTransform x, y ))
            |> ImageGeometry.mapObject (\( x, y ) -> ( x, yTransform y ))
