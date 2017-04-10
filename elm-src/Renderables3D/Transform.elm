module Renderables3D.Transform exposing (Transform(..))

import Renderables3D.Vector3D as Vector3D exposing (Vector3D)


type Transform
    = Translate Vector3D
    | Scale Vector3D
    | Rotate Vector3D
