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
