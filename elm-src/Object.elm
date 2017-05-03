module Object exposing (..)

import Transform exposing (Transform3D(..))
import Geometry exposing (..)
import LineSegment exposing (LineSegment)
import Point exposing (Point(..))
import Vector3D exposing (Vector3D)


type ObjectTree
    = Empty
    | Node Object


type alias Object =
    { geometry : Geometry
    , transforms : List Transform3D
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
        allTransformsAsFunctions : List Transform -> (Point -> Point)
        allTransformsAsFunctions transforms =
            List.map Transform.applyTransform transforms
                |> List.foldl (>>) identity
    in
        List.map
            (\ls -> LineSegment.map (allTransformsAsFunctions object.transforms) ls)
            object.geometry


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
