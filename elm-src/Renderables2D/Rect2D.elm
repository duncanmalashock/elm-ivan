module Renderables2D.Rect2D exposing (..)

import Renderables2D.Line2D as Line2D exposing (Line2D)


type alias Rect2D =
    { minX : Float
    , maxX : Float
    , minY : Float
    , maxY : Float
    }


normalize : Rect2D -> Rect2D -> Line2D -> Line2D
normalize inBoundary outBoundary theLine =
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

        ( x1', y1' ) =
            theLine.start

        ( x2', y2' ) =
            theLine.end
    in
        Line2D ( xTransform x1', yTransform y1' ) ( xTransform x2', yTransform y2' )
