module Renderables3D.Geometry exposing (..)

import Renderables3D.LineSegment as LineSegment exposing (LineSegment)


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
