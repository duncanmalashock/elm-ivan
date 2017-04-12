module Renderables3D.Object exposing (..)

import Renderables3D.Transform as Transform exposing (Transform)
import Renderables3D.Line3D as Line3D exposing (Line3D)
import Tree exposing (Tree(..), empty)


type ObjectTree
    = Obj (Tree Object)


emptyObjectTree : ObjectTree
emptyObjectTree =
    Obj Tree.empty


objectTreeFromObject : Object -> ObjectTree
objectTreeFromObject object =
    Obj (Node object)


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


renderTree : ObjectTree -> List Line3D
renderTree objectTree =
    case objectTree of
        Obj tree ->
            case tree of
                Empty ->
                    []

                Node object ->
                    List.concat [ renderTree object.children, render object ]
