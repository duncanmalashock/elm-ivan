module Renderables3D.Line3D exposing (..)

import Renderables3D.Vector3D as Vector3D exposing (Vector3D)
import Renderables3D.Transform as Transform exposing (Transform)


type alias Line3D =
    { start : Vector3D
    , end : Vector3D
    }


applyTransform : Transform -> Line3D -> Line3D
applyTransform transform theLine =
    case transform of
        Transform.Translate delta ->
            { theLine
                | start = Vector3D.translate delta theLine.start
                , end = Vector3D.translate delta theLine.end
            }

        Transform.Scale amount ->
            { theLine
                | start = Vector3D.scale amount theLine.start
                , end = Vector3D.scale amount theLine.end
            }

        Transform.Rotate theta ->
            { theLine
                | start = Vector3D.rotate theta theLine.start
                , end = Vector3D.rotate theta theLine.end
            }
