module ObjectTree
    exposing
        ( ObjectTree(..)
        , toObject
        , objectToTree
        , emptyObjectTree
        , addSibling
        , addTransform
        )

import Vector exposing (Vector3D)
import Transform exposing (Transform3D)
import ModelGeometry


type ObjectTree
    = Node (List Transform3D) (List ObjectTree)
    | Leaf ModelGeometry.Object


objectToTree : ModelGeometry.Object -> ObjectTree
objectToTree object =
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
            Node [] [ thisOne, objectToTree object ]


addTransform : Transform3D -> ObjectTree -> ObjectTree
addTransform transform tree =
    case tree of
        Node transforms childTrees ->
            Node (transform :: transforms) childTrees

        Leaf object ->
            Node [ transform ] [ objectToTree object ]



{- -}


allTransformsAsFunctions : List Transform3D -> (Vector3D -> Vector3D)
allTransformsAsFunctions transforms =
    transforms
        |> List.map Transform.applyTransform3D
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
        Node childTransforms childTrees ->
            applyTransformsToTrees childTransforms childTrees
                |> List.map (applyTransformsToObject transforms)

        Leaf object ->
            [ applyTransformsToObject transforms object ]


applyTransformsToTrees : List Transform3D -> List ObjectTree -> List ModelGeometry.Object
applyTransformsToTrees transforms trees =
    List.map (applyTransformsToTree transforms) trees
        |> List.concat


toObject : ObjectTree -> ModelGeometry.Object
toObject tree =
    let
        objectList =
            case tree of
                Node transforms childTrees ->
                    applyTransformsToTrees transforms childTrees

                Leaf object ->
                    [ object ]
    in
        List.concat objectList
