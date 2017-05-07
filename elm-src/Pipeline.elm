port module Pipeline
    exposing
        ( toSceneObject
        , toImageObject
        , perspectiveProjection
        , outputToDevice
        )

import ModelGeometry
import SceneGeometry
import ImageGeometry
import DeviceGeometry
import ObjectTree exposing (ObjectTree)
import Vector exposing (Vector3D, Vector2D)


port sendDrawingInstructions : DeviceGeometry.Output -> Cmd msg


toSceneObject : ObjectTree -> SceneGeometry.Object
toSceneObject objectTree =
    objectTree
        |> ObjectTree.toObject
        |> List.map toSceneLineSegment


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


perspectiveProjection : Vector3D -> Vector2D
perspectiveProjection ( x, y, z ) =
    let
        ( povX, povY, povZ ) =
            ( 200, 200, -800 )
    in
        ( (povZ * (x - povX) / (z + povZ) + povX)
        , (povZ * (y - povY) / (z + povZ) + povY)
        )



{- -}


toDeviceObject :
    ImageGeometry.Bounds
    -> ImageGeometry.Bounds
    -> ImageGeometry.Object
    -> DeviceGeometry.Object
toDeviceObject imageBounds deviceBounds imageObject =
    imageObject
        |> ImageGeometry.normalize imageBounds deviceBounds
        |> List.map toDeviceLineSegment


toDeviceLineSegment : ImageGeometry.LineSegment -> DeviceGeometry.LineSegment
toDeviceLineSegment ( start, end ) =
    ( toDevicePoint 0 start
    , toDevicePoint 63 end
    )


toDevicePoint : Int -> ImageGeometry.Point -> DeviceGeometry.Point
toDevicePoint brightness (ImageGeometry.Point ( x, y )) =
    DeviceGeometry.Point ( truncate x, truncate y, brightness )


outputToDevice :
    ImageGeometry.Bounds
    -> ImageGeometry.Bounds
    -> ImageGeometry.Object
    -> Cmd msg
outputToDevice imageBounds deviceBounds renderedImage =
    renderedImage
        |> toDeviceObject imageBounds deviceBounds
        |> DeviceGeometry.toDeviceOutput
        |> sendDrawingInstructions
