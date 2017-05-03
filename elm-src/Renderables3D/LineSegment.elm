module Renderables3D.LineSegment exposing (..)

import Renderables3D.Vector3D as Vector3D exposing (Vector3D)
import Renderables3D.Transform as Transform exposing (Transform)


type alias LineSegment =
    ( Vector3D, Vector3D )


applyTransform : Transform -> LineSegment -> LineSegment
applyTransform transform ( start, end ) =
    case transform of
        Transform.Translate delta ->
            ( Vector3D.translate delta start
            , Vector3D.translate delta end
            )

        Transform.Scale amount ->
            ( Vector3D.scale amount start
            , Vector3D.scale amount end
            )

        Transform.Rotate theta ->
            ( Vector3D.rotate theta start
            , Vector3D.rotate theta end
            )
