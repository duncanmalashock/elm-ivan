module Transform
    exposing
        ( Transform3D(..)
        , applyTransform3D
        )

import Vector exposing (Vector3D, Vector2D)


type Transform3D
    = Identity3D
    | Translate3D Vector3D
    | Scale3D Vector3D
    | Rotate3D Vector3D


applyTransform3D : Transform3D -> Vector3D -> Vector3D
applyTransform3D transform ( x, y, z ) =
    case transform of
        Identity3D ->
            ( x, y, z )

        Translate3D ( dx, dy, dz ) ->
            ( x + dx, y + dy, z + dz )

        Scale3D ( dx, dy, dz ) ->
            ( x * dx, y * dy, z * dz )

        Rotate3D ( dx, dy, dz ) ->
            rotateX dx <|
                rotateY dy <|
                    rotateZ dz ( x, y, z )


rotateX : Float -> Vector3D -> Vector3D
rotateX theta ( x, y, z ) =
    ( x
    , y * cos (degrees theta) - z * sin (degrees theta)
    , y * sin (degrees theta) + z * cos (degrees theta)
    )


rotateY : Float -> Vector3D -> Vector3D
rotateY theta ( x, y, z ) =
    ( z * sin (degrees theta) + x * cos (degrees theta)
    , y
    , z * cos (degrees theta) - x * sin (degrees theta)
    )


rotateZ : Float -> Vector3D -> Vector3D
rotateZ theta ( x, y, z ) =
    ( x * cos (degrees theta) - y * sin (degrees theta)
    , x * sin (degrees theta) + y * cos (degrees theta)
    , z
    )
