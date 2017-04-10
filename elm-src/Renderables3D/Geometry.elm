module Renderables3D.Geometry exposing (..)

import Renderables3D.Line3D as Line3D exposing (Line3D)


type alias Geometry =
    List Line3D


cube : Geometry
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
