module View.EventList exposing (eventList)

-- External modules

import Html exposing (..)
import Html.CssHelpers


-- Local modules

import Types exposing (..)
import View.Event exposing (event)
import Stylesheets exposing (CssClasses(..))


{ id, class, classList } =
    Html.CssHelpers.withNamespace ""



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
            div [ class [ Stylesheets.EventList ] ]
                (List.map event data)
