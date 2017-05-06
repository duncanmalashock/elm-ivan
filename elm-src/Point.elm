module Point exposing (ModelPoint(ModelPoint), ScenePoint(ScenePoint))

import Vector exposing (Vector3D, Vector2D)


type ModelPoint
    = ModelPoint Vector3D


type ScenePoint
    = ScenePoint Vector3D


applyTransform3DFunction : (Vector3D -> Vector3D) -> ModelPoint -> ModelPoint
applyTransform3DFunction transformFunction (ModelPoint coordinates) =
    ModelPoint <| transformFunction coordinates
