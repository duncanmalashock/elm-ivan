module LineSegment exposing (..)

import Point exposing (Point)


type alias LineSegment =
    ( Point, Point )


map func =
    Tuple.mapFirst func
        >> Tuple.mapSecond func
