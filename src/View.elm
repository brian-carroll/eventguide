module View exposing (root)

-- External modules

import Html exposing (..)
import Html.Attributes exposing (..)


-- Local modules

import Types exposing (..)
import View.EventList exposing (eventList)
import View.Header exposing (siteHeader)
import View.Modal exposing (modal)


root : Model -> Html Msg
root model =
    div []
        [ siteHeader
        , eventList model.events
        , modal model
        ]
