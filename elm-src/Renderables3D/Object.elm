module Renderables3D.Object exposing (..)

import Renderables3D.Transform as Transform exposing (Transform)
import Renderables3D.Line3D as Line3D exposing (Line3D)


type alias Object =
    { geometry : List Line3D
    , position : Transform
    , scale : Transform
    , rotation : Transform
    }


render : Object -> List Line3D
render object =
    List.map
        ((Line3D.scale object.scale)
            >> (Line3D.rotate object.rotation)
            >> (Line3D.translate object.position)
        )
        object.geometry
