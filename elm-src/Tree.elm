module Tree exposing (Tree(..), empty)


type Tree value
    = Empty
    | Node value List (Tree value)


empty : Tree a
empty =
    Empty
