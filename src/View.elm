module View exposing (root)

-- External modules

import Html exposing (..)
import Html.Attributes exposing (..)


-- import Html.Events exposing (..)
-- import Dict exposing (Dict)
-- Local modules

import Types exposing (..)
import View.EventList exposing (eventList)
import View.Header exposing (siteHeader)


root : Model -> Html Msg
root model =
    div []
        [ siteHeader
        , eventList model.events
        ]
