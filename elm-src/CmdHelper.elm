module CmdHelper exposing (..)

import Task


cmdFromMsg : msg -> Cmd msg
cmdFromMsg msg =
    Task.perform identity identity <| Task.succeed msg
