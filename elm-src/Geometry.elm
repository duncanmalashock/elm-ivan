module Geometry exposing (..)

import LineSegment as LineSegment exposing (LineSegment)


type alias Geometry =
    List LineSegment


cube : Geometry
cube =
    let
        edgeLength =
            50
    in
        [ ( ( -edgeLength, -edgeLength, -edgeLength ), ( edgeLength, -edgeLength, -edgeLength ) )
        , ( ( edgeLength, -edgeLength, -edgeLength ), ( edgeLength, edgeLength, -edgeLength ) )
        , ( ( edgeLength, edgeLength, -edgeLength ), ( -edgeLength, edgeLength, -edgeLength ) )
        , ( ( -edgeLength, edgeLength, -edgeLength ), ( -edgeLength, -edgeLength, -edgeLength ) )
        , ( ( -edgeLength, -edgeLength, edgeLength ), ( edgeLength, -edgeLength, edgeLength ) )
        , ( ( edgeLength, -edgeLength, edgeLength ), ( edgeLength, edgeLength, edgeLength ) )
        , ( ( edgeLength, edgeLength, edgeLength ), ( -edgeLength, edgeLength, edgeLength ) )
        , ( ( -edgeLength, edgeLength, edgeLength ), ( -edgeLength, -edgeLength, edgeLength ) )
        , ( ( -edgeLength, -edgeLength, edgeLength ), ( -edgeLength, -edgeLength, -edgeLength ) )
        , ( ( edgeLength, -edgeLength, edgeLength ), ( edgeLength, -edgeLength, -edgeLength ) )
        , ( ( edgeLength, edgeLength, edgeLength ), ( edgeLength, edgeLength, -edgeLength ) )
        , ( ( -edgeLength, edgeLength, edgeLength ), ( -edgeLength, edgeLength, -edgeLength ) )
        ]
