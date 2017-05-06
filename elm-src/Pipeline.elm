module Pipeline exposing (..)

import ModelGeometry
import SceneGeometry
import ImageGeometry
import Vector exposing (Vector3D, Vector2D)


toSceneObject : ModelGeometry.Object -> SceneGeometry.Object
toSceneObject modelObject =
    List.map toSceneLineSegment modelObject


toSceneLineSegment : ModelGeometry.LineSegment -> SceneGeometry.LineSegment
toSceneLineSegment ( start, end ) =
    ( toScenePoint start
    , toScenePoint end
    )


toScenePoint : ModelGeometry.Point -> SceneGeometry.Point
toScenePoint (ModelGeometry.Point vector) =
    SceneGeometry.Point vector



{- -}


toImageObject :
    (Vector3D -> Vector2D)
    -> SceneGeometry.Object
    -> ImageGeometry.Object
toImageObject projection sceneObject =
    List.map (toImageLineSegment projection) sceneObject


toImageLineSegment :
    (Vector3D -> Vector2D)
    -> SceneGeometry.LineSegment
    -> ImageGeometry.LineSegment
toImageLineSegment projection ( start, end ) =
    ( toImagePoint projection start
    , toImagePoint projection end
    )


toImagePoint :
    (Vector3D -> Vector2D)
    -> SceneGeometry.Point
    -> ImageGeometry.Point
toImagePoint projection (SceneGeometry.Point vector) =
    ImageGeometry.Point (projection vector)



{- -}


perspectiveProjection : Vector3D -> Vector2D
perspectiveProjection ( x, y, z ) =
    let
        ( povX, povY, povZ ) =
            ( 200, 200, -800 )
    in
        ( (povZ * (x - povX) / (z + povZ) + povX)
        , (povZ * (y - povY) / (z + povZ) + povY)
        )
