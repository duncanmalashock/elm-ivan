module Renderables3D.Object exposing (..)

import Renderables3D.Transform as Transform exposing (Transform)
import Renderables3D.Line3D as Line3D exposing (Line3D)
import Tree exposing (Tree(..), empty)


type ObjectTree
    = Obj (Tree Object)


emptyObjectTree : ObjectTree
emptyObjectTree =
    Obj Tree.empty


type alias Object =
    { geometry : List Line3D
    , transforms : List Transform
    , children : ObjectTree
    }


render : Object -> List Line3D
render object =
    let
        allTransforms =
            List.map Line3D.applyTransform object.transforms
                |> List.foldl (>>) identity
    in
        List.map (allTransforms) object.geometry