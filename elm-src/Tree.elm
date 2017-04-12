module Tree exposing (Tree(..), empty)


type Tree value
    = Empty
    | Node value


empty : Tree a
empty =
    Empty
