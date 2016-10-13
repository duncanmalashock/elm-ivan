module Renderables2D.Geometry2D exposing (..)

import Renderables2D.Line2D as Line2D exposing (Line2D)


type alias Geometry2D =
    List Line2D


square : Geometry2D
square =
    [ Line2D ( -50, -50 ) ( 50, -50 )
    , Line2D ( 50, -50 ) ( 50, 50 )
    , Line2D ( 50, 50 ) ( -50, 50 )
    , Line2D ( -50, 50 ) ( -50, -50 )
    ]
