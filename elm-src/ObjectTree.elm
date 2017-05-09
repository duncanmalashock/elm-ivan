module ObjectTree
    exposing
        ( ObjectTree
        , Id(Id)
        , toObject
        , objectToTree
        , emptyObjectTree
        , addToGroup
        , addTransform
        )

import Vector exposing (Vector3D)
import Transform exposing (Transform3D)
import ModelGeometry


type Id
    = Id Int


type alias ObjectWithId =
    { id : Id, object : ModelGeometry.Object }


mapObjectWithId : (ModelGeometry.Object -> ModelGeometry.Object) -> ObjectWithId -> ObjectWithId
mapObjectWithId fn objectWithId =
    { objectWithId | object = fn objectWithId.object }


type ObjectTree
    = Group (List Transform3D) (List ObjectTree)
    | Object ObjectWithId


objectToTree : Id -> ModelGeometry.Object -> ObjectTree
objectToTree id object =
    Object { id = id, object = object }


emptyObjectTree : ObjectTree
emptyObjectTree =
    Group [] []


addToGroup : ObjectTree -> ObjectTree -> ObjectTree
addToGroup thisOne toThis =
    case toThis of
        Group transforms childTrees ->
            Group transforms (thisOne :: childTrees)

        Object _ ->
            Group [] [ thisOne, toThis ]


addTransform : Transform3D -> ObjectTree -> ObjectTree
addTransform transform tree =
    case tree of
        Group transforms childTrees ->
            Group (transform :: transforms) childTrees

        Object _ ->
            Group [ transform ] [ tree ]



{- -}


allTransformsAsFunctions : List Transform3D -> (Vector3D -> Vector3D)
allTransformsAsFunctions transforms =
    transforms
        |> List.map Transform.applyTransform3D
        |> List.foldl (>>) identity


applyTransformsToObject : List Transform3D -> ObjectWithId -> ObjectWithId
applyTransformsToObject transforms objectWithId =
    let
        mapObject =
            ModelGeometry.mapObject <| allTransformsAsFunctions transforms
    in
        mapObjectWithId mapObject objectWithId


applyTransformsToTree : List Transform3D -> ObjectTree -> List ObjectWithId
applyTransformsToTree transforms tree =
    case tree of
        Group childTransforms childTrees ->
            applyTransformsToTrees childTransforms childTrees
                |> List.map (applyTransformsToObject transforms)

        Object object ->
            [ applyTransformsToObject transforms object ]


applyTransformsToTrees : List Transform3D -> List ObjectTree -> List ObjectWithId
applyTransformsToTrees transforms trees =
    List.map (applyTransformsToTree transforms) trees
        |> List.concat


toObject : ObjectTree -> ModelGeometry.Object
toObject tree =
    let
        objectList =
            case tree of
                Group transforms childTrees ->
                    applyTransformsToTrees transforms childTrees

                Object object ->
                    [ object ]
    in
        objectList
            |> List.map .object
            |> List.concat
