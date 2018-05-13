module App.Model exposing (..)

import Char
import String


type Status
    = Active
    | Complete


type alias Item =
    { id : Int
    , name : String
    , status : Status
    }


type Filter
    = All
    | WithStatus Status


type alias Model =
    { counterValue : Int
    , filter : Filter
    , items : List Item
    }


unfold : (a -> Maybe ( a, b )) -> a -> List b
unfold f a =
    case f a of
        Nothing ->
            []

        Just ( nextA, x ) ->
            x :: unfold f nextA


genItem : Int -> Item
genItem index =
    { id = index
    , name = genName index
    , status = genStatus index
    }


genName : Int -> String
genName index =
    index
        |> unfold
            (\acc ->
                if acc > 0 then
                    Just ( acc - 1, Char.fromCode (acc % 26 + 65) )
                else
                    Nothing
            )
        |> String.fromList


genStatus : Int -> Status
genStatus i =
    if i % 2 == 0 then
        Active
    else
        Complete


model : Model
model =
    { counterValue = 0
    , filter = All
    , items =
        List.repeat 3000 ()
            |> List.indexedMap (\index _ -> index)
            |> List.map genItem
    }
