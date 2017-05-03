module Renderables3D.Geometry exposing (..)

import Renderables3D.Line3D as Line3D exposing (Line3D)


type alias Geometry =
    List Line3D


cube : Geometry
cube =
    let
        edgeLength =
            50
    in
        [ Line3D ( -edgeLength, -edgeLength, -edgeLength ) ( edgeLength, -edgeLength, -edgeLength )
        , Line3D ( edgeLength, -edgeLength, -edgeLength ) ( edgeLength, edgeLength, -edgeLength )
        , Line3D ( edgeLength, edgeLength, -edgeLength ) ( -edgeLength, edgeLength, -edgeLength )
        , Line3D ( -edgeLength, edgeLength, -edgeLength ) ( -edgeLength, -edgeLength, -edgeLength )
        , Line3D ( -edgeLength, -edgeLength, edgeLength ) ( edgeLength, -edgeLength, edgeLength )
        , Line3D ( edgeLength, -edgeLength, edgeLength ) ( edgeLength, edgeLength, edgeLength )
        , Line3D ( edgeLength, edgeLength, edgeLength ) ( -edgeLength, edgeLength, edgeLength )
        , Line3D ( -edgeLength, edgeLength, edgeLength ) ( -edgeLength, -edgeLength, edgeLength )
        , Line3D ( -edgeLength, -edgeLength, edgeLength ) ( -edgeLength, -edgeLength, -edgeLength )
        , Line3D ( edgeLength, -edgeLength, edgeLength ) ( edgeLength, -edgeLength, -edgeLength )
        , Line3D ( edgeLength, edgeLength, edgeLength ) ( edgeLength, edgeLength, -edgeLength )
        , Line3D ( -edgeLength, edgeLength, edgeLength ) ( -edgeLength, edgeLength, -edgeLength )
        ]
