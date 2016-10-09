module Vector2D exposing (..)


type alias Vector2D =
    ( Int, Int )


translate : Vector2D -> Vector2D -> Vector2D
translate delta point =
    let
        ( x, y ) =
            point

        ( dx, dy ) =
            delta
    in
        ( x + dx, y + dy )
