module Renderables3D.Vector3D exposing (..)


type alias Vector3D =
    ( Float, Float, Float )


translate : Vector3D -> Vector3D -> Vector3D
translate delta point =
    let
        ( x, y, z ) =
            point

        ( dx, dy, dz ) =
            delta
    in
        ( x + dx, y + dy, z + dz )


scale : Float -> Vector3D -> Vector3D
scale amount point =
    let
        ( x, y, z ) =
            point
    in
        ( x * amount, y * amount, z * amount )


rotate : ( Float, Float, Float ) -> Vector3D -> Vector3D
rotate theta point =
    let
        ( thetaX, thetaY, thetaZ ) =
            theta
    in
        rotateX thetaX <|
            rotateY thetaY <|
                rotateZ thetaZ point


rotateX : Float -> Vector3D -> Vector3D
rotateX theta point =
    let
        ( x, y, z ) =
            point
    in
        ( x
        , y * cos (degrees theta) - z * sin (degrees theta)
        , y * sin (degrees theta) + z * cos (degrees theta)
        )


rotateY : Float -> Vector3D -> Vector3D
rotateY theta point =
    let
        ( x, y, z ) =
            point
    in
        ( z * sin (degrees theta) + x * cos (degrees theta)
        , y
        , z * cos (degrees theta) - x * sin (degrees theta)
        )


rotateZ : Float -> Vector3D -> Vector3D
rotateZ theta point =
    let
        ( x, y, z ) =
            point
    in
        ( x * cos (degrees theta) - y * sin (degrees theta)
        , x * sin (degrees theta) + y * cos (degrees theta)
        , z
        )
