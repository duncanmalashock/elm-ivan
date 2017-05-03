module Object exposing (..)

import Transform as Transform exposing (Transform)
import LineSegment as LineSegment exposing (LineSegment)
import Point as Point exposing (Point(..))


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
