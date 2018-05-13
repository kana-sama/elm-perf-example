module App.Selectors exposing (..)

import Debug exposing (log)
import App.Model exposing (Model, Item, Filter(..))


selectCounterValue : Model -> Int
selectCounterValue =
    .counterValue


selectFilter : Model -> Filter
selectFilter =
    .filter


selectVisibleItemsSortedByName : Model -> List Item
selectVisibleItemsSortedByName { filter, items } =
    let
        filterVisible =
            case filter of
                All ->
                    identity

                WithStatus status ->
                    List.filter (\item -> item.status == status)
    in
        items
            |> filterVisible
            |> List.sortBy .name
            |> List.reverse
            |> log "recalculate"
