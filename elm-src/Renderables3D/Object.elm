module Renderables3D.Object exposing (..)

import Renderables3D.Transform as Transform exposing (Transform)
import Renderables3D.Line3D as Line3D exposing (Line3D)


type ObjectTree
    = Empty
    | Node Object


type alias Object =
    { geometry : List Line3D
    , transforms : List Transform
    , children : List ObjectTree
    }


objectTreeFromObject : Object -> ObjectTree
objectTreeFromObject object =
    Node object


emptyObjectTree : ObjectTree
emptyObjectTree =
    Empty


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
        Empty ->
            []

        Node value ->
            List.concat [ List.concat <| List.map renderTree value.children, render value ]
