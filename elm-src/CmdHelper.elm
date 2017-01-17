module CmdHelper exposing (..)

import Task


cmdFromMsg : msg -> Cmd msg
cmdFromMsg msg =
    Task.perform (\x -> msg) (Task.succeed Nothing)
