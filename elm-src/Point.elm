module Point exposing (Point(..))

import Vector exposing (Vector3D)


type Point
    = InModelSpace Vector3D
    | InSceneSpace Vector3D


applyTransform3DFunction :
    (Vector3D -> Vector3D)
    -> Point
    -> Result String Point
applyTransform3DFunction transformFunction point =
    case point of
        InModelSpace coordinates ->
            Ok (InModelSpace <| transformFunction coordinates)

        _ ->
            Err <| "Couldn't apply 3D transform to " ++ (toString point)
