module Renderables3D.Geometry3D exposing (..)

import Renderables3D.Line3D as Line3D exposing (Line3D)


type alias Geometry3D =
    List Line3D


cube : Geometry3D
cube =
    [ Line3D ( -50, -50, -50 ) ( 50, -50, -50 )
    , Line3D ( 50, -50, -50 ) ( 50, 50, -50 )
    , Line3D ( 50, 50, -50 ) ( -50, 50, -50 )
    , Line3D ( -50, 50, -50 ) ( -50, -50, -50 )
    , Line3D ( -50, -50, 50 ) ( 50, -50, 50 )
    , Line3D ( 50, -50, 50 ) ( 50, 50, 50 )
    , Line3D ( 50, 50, 50 ) ( -50, 50, 50 )
    , Line3D ( -50, 50, 50 ) ( -50, -50, 50 )
    , Line3D ( -50, -50, 50 ) ( -50, -50, -50 )
    , Line3D ( 50, -50, 50 ) ( 50, -50, -50 )
    , Line3D ( 50, 50, 50 ) ( 50, 50, -50 )
    , Line3D ( -50, 50, 50 ) ( -50, 50, -50 )
    ]
