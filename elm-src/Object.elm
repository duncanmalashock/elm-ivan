module Object exposing (..)

import Transform exposing (Transform3D(..))
import Geometry exposing (..)
import Point exposing (Point(..))
import Vector3D exposing (Vector3D)


type ObjectTree
    = Empty
    | Node Object


type alias Object =
    { geometry : List LineSegment
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


render : Object -> Result String (List LineSegment)
render object =
    Geometry.applyTransform3DFunction
        (allTransformsAsFunctions object.transforms)
        object.geometry


renderChildren : Object -> List (Result String (List LineSegment))
renderChildren obj =
    List.map
        ((addTransformsToObjectTree obj.transforms) >> renderTree)
        obj.children


appendResults :
    Result String (List LineSegment)
    -> Result String (List LineSegment)
    -> Result String (List LineSegment)
appendResults resultWithList1 resultWithList2 =
    Result.map2 (List.append) resultWithList1 resultWithList2


renderTree : ObjectTree -> Result String (List LineSegment)
renderTree objectTree =
    case objectTree of
        Node obj ->
            let
                resultWithRenderedChildren =
                    Result.map
                        (List.concat)
                        (Geometry.combineResults <| renderChildren obj)
            in
                appendResults (render obj) resultWithRenderedChildren

        Empty ->
            Ok []
