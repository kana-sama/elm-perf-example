module App.View exposing (view)

import Html exposing (Html, div, li, text, button)
import Html.Events exposing (onClick)
import Html.Keyed exposing (ul)
import Html.Lazy exposing (lazy)
import App.Model exposing (Model, Item, Filter(..), Status(..))
import App.Update exposing (Msg(..))
import App.Selectors exposing (..)


view : Model -> Html Msg
view model =
    div
        []
        [ viewCounter model
        , viewFilter model
        , viewItems model
        ]


viewCounter : Model -> Html Msg
viewCounter model =
    let
        counterValue =
            selectCounterValue model
    in
        button
            [ onClick Increment ]
            [ text (toString counterValue)
            , text " - "
            , text "inc"
            ]


viewFilter : Model -> Html Msg
viewFilter model =
    case selectFilter model of
        All ->
            button [ onClick (SetFilter (WithStatus Active)) ] [ text "all -> show active" ]

        WithStatus Active ->
            button [ onClick (SetFilter (WithStatus Complete)) ] [ text "active -> show complete" ]

        WithStatus Complete ->
            button [ onClick (SetFilter All) ] [ text "complte -> show all" ]


viewItems : Model -> Html Msg
viewItems =
    lazy <|
        \model ->
            let
                items =
                    selectVisibleItemsSortedByName model
            in
                ul [] <|
                    List.map
                        (\item ->
                            ( toString item.id
                            , viewItem item
                            )
                        )
                        items


viewItem : Item -> Html Msg
viewItem { name, status } =
    li
        []
        [ text name
        , text " - "
        , text (toString status)
        ]
