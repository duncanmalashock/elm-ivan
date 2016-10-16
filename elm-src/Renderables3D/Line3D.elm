module Renderables3D.Line3D exposing (..)

import Renderables3D.Vector3D as Vector3D exposing (Vector3D)


type alias Line3D =
    { start : Vector3D
    , end : Vector3D
    }


translate : Vector3D -> Line3D -> Line3D
translate delta theLine =
    { theLine
        | start = Vector3D.translate delta theLine.start
        , end = Vector3D.translate delta theLine.end
    }


scale : Float -> Line3D -> Line3D
scale amount theLine =
    { theLine
        | start = Vector3D.scale amount theLine.start
        , end = Vector3D.scale amount theLine.end
    }


rotate : ( Float, Float, Float ) -> Line3D -> Line3D
rotate theta theLine =
    { theLine
        | start = Vector3D.rotate theta theLine.start
        , end = Vector3D.rotate theta theLine.end
    }
