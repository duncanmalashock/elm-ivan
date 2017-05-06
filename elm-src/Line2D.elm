module Line2D exposing (..)

import String
import Transform exposing (..)
import Vector exposing (Vector2D)


type alias Line2D =
    ( Vector2D, Vector2D )


asString : Line2D -> String
asString ( start, end ) =
    let
        ( x1, y1 ) =
            start

        ( x2, y2 ) =
            end
    in
        String.join " " <| List.map (floor >> toString) [ x1, y1, x2, y2 ]


asInts : Line2D -> List (List Int)
asInts ( start, end ) =
    let
        ( x1, y1 ) =
            start

        ( x2, y2 ) =
            end
    in
        [ [ truncate x1, truncate y1, 0 ]
        , [ truncate x2, truncate y2, 63 ]
        ]


translate : Vector2D -> Line2D -> Line2D
translate delta ( start, end ) =
    ( applyTransform2D (Translate2D delta) start
    , applyTransform2D (Translate2D delta) end
    )


scale : Float -> Line2D -> Line2D
scale amount ( start, end ) =
    ( applyTransform2D (Scale2D amount) start
    , applyTransform2D (Scale2D amount) end
    )


rotateZ : Float -> Line2D -> Line2D
rotateZ theta ( start, end ) =
    ( applyTransform2D (Rotate2D theta) start
    , applyTransform2D (Rotate2D theta) end
    )
