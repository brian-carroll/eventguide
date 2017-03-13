module View exposing (root)

-- External modules

import Html exposing (..)
import Html.Attributes exposing (..)


-- import Html.Events exposing (..)
-- import Dict exposing (Dict)
-- Local modules

import Types exposing (..)
import View.EventList exposing (..)


root : Model -> Html Msg
root model =
    div [ class "container" ]
        [ h1 [] [ text "Brian's Event Guide" ]
        , eventList model.events
        ]
