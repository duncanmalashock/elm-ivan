module Rect2D exposing (..)

import Line2D exposing (Line2D)


type alias Rect2D =
    { minX : Int
    , maxX : Int
    , minY : Int
    , maxY : Int
    }


normalize : Rect2D -> Rect2D -> Line2D -> Line2D
normalize inBoundary outBoundary theLine =
    let
        yTranslate =
            outBoundary.minY - inBoundary.minY

        yScale =
            toFloat (outBoundary.maxY - outBoundary.minY) / toFloat (inBoundary.maxY - inBoundary.minY)

        xTranslate =
            outBoundary.minX - inBoundary.minX

        xScale =
            toFloat (outBoundary.maxX - outBoundary.minX) / toFloat (inBoundary.maxX - inBoundary.minX)

        xTransform : Int -> Int
        xTransform x =
            floor (toFloat (x - inBoundary.minX) * xScale + (toFloat inBoundary.minX) + toFloat xTranslate)

        yTransform : Int -> Int
        yTransform y =
            floor (toFloat (y - inBoundary.minY) * yScale + (toFloat inBoundary.minY) + toFloat yTranslate)

        ( x1', y1' ) =
            theLine.start

        ( x2', y2' ) =
            theLine.end
    in
        Line2D ( xTransform x1', yTransform y1' ) ( xTransform x2', yTransform y2' )
