module Renderables3D.Object3D exposing (..)

import Renderables3D.Transform exposing (Transform)
import Renderables3D.Line3D as Line3D exposing (Line3D)
import Renderables3D.Vector3D as Vector3D exposing (Vector3D)


type alias Object3D =
    { geometry : List Line3D
    , position : Transform
    , scale : Transform
    , rotation : Transform
    }


render : Object3D -> List Line3D
render object =
    List.map
        ((Line3D.scale object.scale)
            >> (Line3D.rotate object.rotation)
            >> (Line3D.translate object.position)
        )
        object.geometry
