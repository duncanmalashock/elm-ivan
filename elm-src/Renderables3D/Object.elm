module Renderables3D.Object exposing (..)

import Renderables3D.Transform as Transform exposing (Transform)
import Renderables3D.Line3D as Line3D exposing (Line3D)


type alias Object =
    { geometry : List Line3D
    , transforms : List Transform
    }


render : Object -> List Line3D
render object =
    let
        allTransforms =
            List.map Line3D.applyTransform object.transforms
                |> List.foldl (>>) identity
    in
        List.map (allTransforms) object.geometry
