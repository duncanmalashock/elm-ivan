module Vector2D exposing (..)


type alias Vector2D =
    ( Float, Float )


translate : Vector2D -> Vector2D -> Vector2D
translate delta point =
    let
        ( x, y ) =
            point

        ( dx, dy ) =
            delta
    in
        ( x + dx, y + dy )


scale : Float -> Vector2D -> Vector2D
scale amount point =
    let
        ( x, y ) =
            point
    in
        ( x * amount, y * amount )
