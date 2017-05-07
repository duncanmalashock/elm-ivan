module DeviceGeometry
    exposing
        ( Object
        , LineSegment
        , Point(Point)
        , Output
        , toDeviceOutput
        )


type alias Output =
    List (List Int)


type Point
    = Point ( Int, Int, Int )


type alias LineSegment =
    ( Point, Point )


type alias Object =
    List LineSegment


toDeviceOutput : Object -> Output
toDeviceOutput object =
    object
        |> List.map lineSegmentToList
        |> List.concat


lineSegmentToList : ( Point, Point ) -> List (List Int)
lineSegmentToList ( start, end ) =
    [ start, end ]
        |> List.map pointToList


pointToList : Point -> List Int
pointToList point =
    case point of
        Point ( x, y, b ) ->
            [ x, y, b ]
