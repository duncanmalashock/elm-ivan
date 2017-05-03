module Geometry exposing (..)

import LineSegment exposing (LineSegment)
import Point exposing (Point(..))


type alias Geometry =
    List LineSegment


cube : Geometry
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
