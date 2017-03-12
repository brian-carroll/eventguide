module View.EventList exposing (eventList)

-- External modules

import Html exposing (..)


-- Local modules

import Types exposing (..)
import View.Event exposing (event)


-- View


eventList : WebData (List Event) -> Html Msg
eventList events =
    case events of
        NotAsked ->
            text "Request not sent yet"

        Loading ->
            text "Loading..."

        Failure error ->
            text (toString error)

        Success data ->
            div []
                (List.map event data)
