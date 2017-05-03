module Renderables3D.Object exposing (..)

import Renderables3D.Transform as Transform exposing (Transform)
import Renderables3D.LineSegment as LineSegment exposing (LineSegment)


type ObjectTree
    = Empty
    | Node Object


type alias Object =
    { geometry : List LineSegment
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


render : Object -> List LineSegment
render object =
    let
        allTransformsAsFunctions : List Transform -> (LineSegment -> LineSegment)
        allTransformsAsFunctions transforms =
            List.map LineSegment.applyTransform transforms
                |> List.foldl (>>) identity
    in
        List.map (allTransformsAsFunctions object.transforms) object.geometry


renderTree : ObjectTree -> List LineSegment
renderTree objectTree =
    case objectTree of
        Node value ->
            List.concat
                (List.map
                    ((addTransformsToObjectTree value.transforms) >> renderTree)
                    value.children
                )
                ++ render value

        Empty ->
            []
