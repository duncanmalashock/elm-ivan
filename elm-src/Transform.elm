module Transform exposing (Transform(..), applyTransform)

import Vector3D as Vector3D exposing (Vector3D)
import LineSegment as LineSegment exposing (LineSegment)


type Transform
    = Translate Vector3D
    | Scale Vector3D
    | Rotate Vector3D


applyTransform : Transform -> LineSegment -> LineSegment
applyTransform transform ( start, end ) =
    case transform of
        Translate delta ->
            ( Vector3D.translate delta start
            , Vector3D.translate delta end
            )

        Scale amount ->
            ( Vector3D.scale amount start
            , Vector3D.scale amount end
            )

        Rotate theta ->
            ( Vector3D.rotate theta start
            , Vector3D.rotate theta end
            )
