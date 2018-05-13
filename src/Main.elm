module Main exposing (..)

import Platform exposing (Program)
import Html exposing (beginnerProgram)
import App.Model exposing (Model, model)
import App.Update exposing (Msg, update)
import App.View exposing (view)


main : Program Never Model Msg
main =
    beginnerProgram
        { model = model
        , update = update
        , view = view
        }
