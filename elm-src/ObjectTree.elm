module ObjectTree exposing (..)

import Vector exposing (Vector3D)
import Transform exposing (Transform3D)
import ModelGeometry


type ObjectTree
    = Node (List Transform3D) (List ObjectTree)
    | Leaf ModelGeometry.Object


singleton : ModelGeometry.Object -> ObjectTree
singleton object =
    Leaf object


emptyObjectTree : ObjectTree
emptyObjectTree =
    Node [] []


addSibling : ObjectTree -> ObjectTree -> ObjectTree
addSibling toThis thisOne =
    case toThis of
        Node transforms childTrees ->
            Node transforms (thisOne :: childTrees)

        Leaf object ->
            Node [] [ thisOne, Leaf object ]


addTransform : Transform3D -> ObjectTree -> ObjectTree
addTransform transform tree =
    case tree of
        Node transforms childTrees ->
            Node (transform :: transforms) childTrees

        Leaf object ->
            Node [ transform ] [ Leaf object ]


allTransformsAsFunctions : List Transform3D -> (Vector3D -> Vector3D)
allTransformsAsFunctions transforms =
    List.map Transform.applyTransform3D transforms
        |> List.foldl (>>) identity


applyTransformsToObject : List Transform3D -> ModelGeometry.Object -> ModelGeometry.Object
applyTransformsToObject transforms object =
    let
        mapObject =
            ModelGeometry.mapObject <| allTransformsAsFunctions transforms
    in
        mapObject object


applyTransformsToTree : List Transform3D -> ObjectTree -> List ModelGeometry.Object
applyTransformsToTree transforms tree =
    case tree of
        Node transforms childTrees ->
            applyTransformsToTrees transforms childTrees

        Leaf object ->
            [ applyTransformsToObject transforms object ]


applyTransformsToTrees : List Transform3D -> List ObjectTree -> List ModelGeometry.Object
applyTransformsToTrees transforms trees =
    List.map (applyTransformsToTree transforms) trees
        |> List.concat


render : ObjectTree -> List ModelGeometry.Object
render tree =
    case tree of
        Node transforms childTrees ->
            applyTransformsToTrees transforms childTrees

        Leaf object ->
            [ object ]
