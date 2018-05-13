module App.Update exposing (..)

import App.Model exposing (Model, Filter(..))


type Msg
    = Increment
    | SetFilter Filter


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | counterValue = model.counterValue + 1 }

        SetFilter filter ->
            { model | filter = filter }
