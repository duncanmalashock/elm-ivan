module Geometry exposing (..)

import Point exposing (Point(..))
import Vector3D exposing (Vector3D)


type alias LineSegment =
    ( Point, Point )


cube : List LineSegment
cube =
    let
        edgeLength =
            50
    in
        [ ( InModelSpace ( -edgeLength, -edgeLength, -edgeLength )
          , InModelSpace ( edgeLength, -edgeLength, -edgeLength )
          )
        , ( InModelSpace ( edgeLength, -edgeLength, -edgeLength )
          , InModelSpace ( edgeLength, edgeLength, -edgeLength )
          )
        , ( InModelSpace ( edgeLength, edgeLength, -edgeLength )
          , InModelSpace ( -edgeLength, edgeLength, -edgeLength )
          )
        , ( InModelSpace ( -edgeLength, edgeLength, -edgeLength )
          , InModelSpace ( -edgeLength, -edgeLength, -edgeLength )
          )
        , ( InModelSpace ( -edgeLength, -edgeLength, edgeLength )
          , InModelSpace ( edgeLength, -edgeLength, edgeLength )
          )
        , ( InModelSpace ( edgeLength, -edgeLength, edgeLength )
          , InModelSpace ( edgeLength, edgeLength, edgeLength )
          )
        , ( InModelSpace ( edgeLength, edgeLength, edgeLength )
          , InModelSpace ( -edgeLength, edgeLength, edgeLength )
          )
        , ( InModelSpace ( -edgeLength, edgeLength, edgeLength )
          , InModelSpace ( -edgeLength, -edgeLength, edgeLength )
          )
        , ( InModelSpace ( -edgeLength, -edgeLength, edgeLength )
          , InModelSpace ( -edgeLength, -edgeLength, -edgeLength )
          )
        , ( InModelSpace ( edgeLength, -edgeLength, edgeLength )
          , InModelSpace ( edgeLength, -edgeLength, -edgeLength )
          )
        , ( InModelSpace ( edgeLength, edgeLength, edgeLength )
          , InModelSpace ( edgeLength, edgeLength, -edgeLength )
          )
        , ( InModelSpace ( -edgeLength, edgeLength, edgeLength )
          , InModelSpace ( -edgeLength, edgeLength, -edgeLength )
          )
        ]


combineResults : List (Result x a) -> Result x (List a)
combineResults =
    List.foldr (Result.map2 (::)) (Ok [])


applyTransform3DFunction :
    (Vector3D -> Vector3D)
    -> List LineSegment
    -> Result String (List LineSegment)
applyTransform3DFunction transformFunction geometry =
    List.map (applyTransform3DFunctionToLineSegment transformFunction) geometry
        |> combineResults


applyTransform3DFunctionToLineSegment :
    (Vector3D -> Vector3D)
    -> LineSegment
    -> Result String LineSegment
applyTransform3DFunctionToLineSegment transformFunction lineSegment =
    case lineSegment of
        ( InModelSpace start, InModelSpace end ) ->
            Ok <|
                ( InModelSpace <| transformFunction start
                , InModelSpace <| transformFunction end
                )

        _ ->
            Err <| "Couldn't apply 3D transform to " ++ (toString lineSegment)
