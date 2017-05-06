module ModelGeometry exposing (..)

import Point exposing (ModelPoint(ModelPoint))
import Vector exposing (Vector3D)


type alias LineSegment =
    ( ModelPoint, ModelPoint )


cube : List LineSegment
cube =
    let
        edgeLength =
            50
    in
        [ ( ModelPoint ( -edgeLength, -edgeLength, -edgeLength )
          , ModelPoint ( edgeLength, -edgeLength, -edgeLength )
          )
        , ( ModelPoint ( edgeLength, -edgeLength, -edgeLength )
          , ModelPoint ( edgeLength, edgeLength, -edgeLength )
          )
        , ( ModelPoint ( edgeLength, edgeLength, -edgeLength )
          , ModelPoint ( -edgeLength, edgeLength, -edgeLength )
          )
        , ( ModelPoint ( -edgeLength, edgeLength, -edgeLength )
          , ModelPoint ( -edgeLength, -edgeLength, -edgeLength )
          )
        , ( ModelPoint ( -edgeLength, -edgeLength, edgeLength )
          , ModelPoint ( edgeLength, -edgeLength, edgeLength )
          )
        , ( ModelPoint ( edgeLength, -edgeLength, edgeLength )
          , ModelPoint ( edgeLength, edgeLength, edgeLength )
          )
        , ( ModelPoint ( edgeLength, edgeLength, edgeLength )
          , ModelPoint ( -edgeLength, edgeLength, edgeLength )
          )
        , ( ModelPoint ( -edgeLength, edgeLength, edgeLength )
          , ModelPoint ( -edgeLength, -edgeLength, edgeLength )
          )
        , ( ModelPoint ( -edgeLength, -edgeLength, edgeLength )
          , ModelPoint ( -edgeLength, -edgeLength, -edgeLength )
          )
        , ( ModelPoint ( edgeLength, -edgeLength, edgeLength )
          , ModelPoint ( edgeLength, -edgeLength, -edgeLength )
          )
        , ( ModelPoint ( edgeLength, edgeLength, edgeLength )
          , ModelPoint ( edgeLength, edgeLength, -edgeLength )
          )
        , ( ModelPoint ( -edgeLength, edgeLength, edgeLength )
          , ModelPoint ( -edgeLength, edgeLength, -edgeLength )
          )
        ]


combineResults : List (Result x a) -> Result x (List a)
combineResults =
    List.foldr (Result.map2 (::)) (Ok [])


applyTransform3DFunction :
    (Vector3D -> Vector3D)
    -> List LineSegment
    -> List LineSegment
applyTransform3DFunction transformFunction geometry =
    List.map (applyTransform3DFunctionToLineSegment transformFunction) geometry


applyTransform3DFunctionToLineSegment :
    (Vector3D -> Vector3D)
    -> LineSegment
    -> LineSegment
applyTransform3DFunctionToLineSegment transformFunction ( ModelPoint start, ModelPoint end ) =
    ( ModelPoint <| transformFunction start
    , ModelPoint <| transformFunction end
    )
