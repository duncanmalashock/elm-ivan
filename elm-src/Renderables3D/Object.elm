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


addTransformsToObjectTree : List Transform -> ObjectTree -> ObjectTree
addTransformsToObjectTree transforms tree =
    case tree of
        Node object ->
            Node { object | transforms = transforms ++ object.transforms }

        Empty ->
            tree


render : Object -> List Line3D
render object =
    let
        allTransformsAsFunctions =
            List.map Line3D.applyTransform object.transforms
                |> List.foldl (>>) identity
    in
        List.map (allTransformsAsFunctions) object.geometry


renderTree : ObjectTree -> List Line3D
renderTree objectTree =
    case objectTree of
        Node value ->
            (List.concat <|
                List.map
                    (renderTree << (addTransformsToObjectTree value.transforms))
                    (value.children)
            )
                ++ render value

        Empty ->
            []
