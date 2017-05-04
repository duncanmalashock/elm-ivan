module Transform
    exposing
        ( Transform3D(..)
        , Transform2D(..)
        , applyTransform2D
        , applyTransform3D
        )

import Vector2D exposing (Vector2D)
import Vector3D exposing (Vector3D)
import Point exposing (Point(..))


type Transform3D
    = Translate3D Vector3D
    | Scale3D Vector3D
    | Rotate3D Vector3D


type Transform2D
    = Translate2D Vector2D
    | Scale2D Float
    | Rotate2D Float


applyTransform3D : Transform3D -> Vector3D -> Vector3D
applyTransform3D transform coordinates =
    case transform of
        Translate3D delta ->
            Vector3D.translate delta coordinates

        Scale3D amount ->
            Vector3D.scale amount coordinates

        Rotate3D theta ->
            Vector3D.rotate theta coordinates


applyTransform2D : Transform2D -> Vector2D -> Vector2D
applyTransform2D transform coordinates =
    case transform of
        Translate2D delta ->
            Vector2D.translate delta coordinates

        Scale2D amount ->
            Vector2D.scale amount coordinates

        Rotate2D theta ->
            Vector2D.rotateZ theta coordinates
