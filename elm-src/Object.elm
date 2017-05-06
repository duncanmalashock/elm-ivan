module Object exposing (..)

import Vector exposing (Vector3D)
import Transform exposing (Transform3D(..))
import ModelGeometry


type ObjectTree
    = Empty
    | Node Object


type alias Object =
    { geometry : List ModelGeometry.LineSegment
    , transforms : List Transform3D
    , children : List ObjectTree
    }


objectTreeFromObject : Object -> ObjectTree
objectTreeFromObject object =
    Node object


emptyObjectTree : ObjectTree
emptyObjectTree =
    Empty


addTransformsToObjectTree : List Transform3D -> ObjectTree -> ObjectTree
addTransformsToObjectTree transforms tree =
    case tree of
        Node object ->
            Node { object | transforms = transforms ++ object.transforms }

        Empty ->
            tree


allTransformsAsFunctions : List Transform3D -> (Vector3D -> Vector3D)
allTransformsAsFunctions transforms =
    List.map Transform.applyTransform3D transforms
        |> List.foldl (>>) identity


render : Object -> List ModelGeometry.LineSegment
render object =
    ModelGeometry.mapObject
        (allTransformsAsFunctions object.transforms)
        object.geometry


renderChildren : Object -> List ModelGeometry.LineSegment
renderChildren obj =
    List.concat <|
        List.map
            ((addTransformsToObjectTree obj.transforms) >> renderTree)
            obj.children


renderTree : ObjectTree -> List ModelGeometry.LineSegment
renderTree objectTree =
    case objectTree of
        Node obj ->
            List.append (render obj) (renderChildren obj)

        Empty ->
            []
