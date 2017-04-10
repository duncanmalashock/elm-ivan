module Renderables3D.Line3D exposing (..)

import Renderables3D.Vector3D as Vector3D exposing (Vector3D)
import Renderables3D.Transform exposing (Transform)


type alias Line3D =
    { start : Vector3D
    , end : Vector3D
    }


translate : Transform -> Line3D -> Line3D
translate transform theLine =
    case transform of
        Renderables3D.Transform.Translate delta ->
            { theLine
                | start = Vector3D.translate delta theLine.start
                , end = Vector3D.translate delta theLine.end
            }

        _ ->
            theLine


scale : Transform -> Line3D -> Line3D
scale transform theLine =
    case transform of
        Renderables3D.Transform.Scale amount ->
            { theLine
                | start = Vector3D.scale amount theLine.start
                , end = Vector3D.scale amount theLine.end
            }

        _ ->
            theLine


rotate : Transform -> Line3D -> Line3D
rotate transform theLine =
    case transform of
        Renderables3D.Transform.Rotate theta ->
            { theLine
                | start = Vector3D.rotate theta theLine.start
                , end = Vector3D.rotate theta theLine.end
            }

        _ ->
            theLine
