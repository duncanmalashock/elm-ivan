module Transform exposing (Transform(..), applyTransform)

import Vector2D exposing (Vector2D)
import Vector3D exposing (Vector3D)
import Point exposing (Point(..))


type Transform
    = Translate Vector3D
    | Scale Vector3D
    | Rotate Vector3D


applyTransform : Transform -> Point -> Point
applyTransform transform point =
    case transform of
        Translate delta ->
            case point of
                InModelSpace coordinates ->
                    InModelSpace <| Vector3D.translate delta coordinates

        Scale amount ->
            case point of
                InModelSpace coordinates ->
                    InModelSpace <| Vector3D.scale amount coordinates

        Rotate theta ->
            case point of
                InModelSpace coordinates ->
                    InModelSpace <| Vector3D.rotate theta coordinates
