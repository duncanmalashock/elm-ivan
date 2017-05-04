module Geometry exposing (..)

import Point exposing (Point(..))
import Vector3D exposing (Vector3D)


type alias LineSegment =
    ( Point, Point )


cube : List LineSegment
cube =
    let
        edgeLength =
            50
    in
        [ ( InModelSpace ( -edgeLength, -edgeLength, -edgeLength ), InModelSpace ( edgeLength, -edgeLength, -edgeLength ) )
        , ( InModelSpace ( edgeLength, -edgeLength, -edgeLength ), InModelSpace ( edgeLength, edgeLength, -edgeLength ) )
        , ( InModelSpace ( edgeLength, edgeLength, -edgeLength ), InModelSpace ( -edgeLength, edgeLength, -edgeLength ) )
        , ( InModelSpace ( -edgeLength, edgeLength, -edgeLength ), InModelSpace ( -edgeLength, -edgeLength, -edgeLength ) )
        , ( InModelSpace ( -edgeLength, -edgeLength, edgeLength ), InModelSpace ( edgeLength, -edgeLength, edgeLength ) )
        , ( InModelSpace ( edgeLength, -edgeLength, edgeLength ), InModelSpace ( edgeLength, edgeLength, edgeLength ) )
        , ( InModelSpace ( edgeLength, edgeLength, edgeLength ), InModelSpace ( -edgeLength, edgeLength, edgeLength ) )
        , ( InModelSpace ( -edgeLength, edgeLength, edgeLength ), InModelSpace ( -edgeLength, -edgeLength, edgeLength ) )
        , ( InModelSpace ( -edgeLength, -edgeLength, edgeLength ), InModelSpace ( -edgeLength, -edgeLength, -edgeLength ) )
        , ( InModelSpace ( edgeLength, -edgeLength, edgeLength ), InModelSpace ( edgeLength, -edgeLength, -edgeLength ) )
        , ( InModelSpace ( edgeLength, edgeLength, edgeLength ), InModelSpace ( edgeLength, edgeLength, -edgeLength ) )
        , ( InModelSpace ( -edgeLength, edgeLength, edgeLength ), InModelSpace ( -edgeLength, edgeLength, -edgeLength ) )
        ]
