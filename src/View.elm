module View exposing (root)

-- External modules
import Html exposing (..)
import Html.Attributes exposing (..)
import Maybe

-- Local modules
import Types exposing (..)
import TicketMaster


root : Model -> Html Msg
root model =
    div []
        [ tmdata model.data
        ]

tmdata : WebData { a | events : List TicketMaster.Event } -> Html Msg
tmdata webdata =
    case webdata of
        NotAsked ->
            text "Request not sent yet"
        Loading ->
            text "Loading..."
        Failure error ->
            text (toString error)
        Success data ->
            div []
                (List.map tmevent data.events)


tmevent : TicketMaster.Event -> Html Msg
tmevent event =
    div []
        [ a [ href event.url ]
            [ text event.name
            ]
        , img [src (firstEventImageUrl event)] []
        ]

firstEventImageUrl : TicketMaster.Event -> String
firstEventImageUrl event =
    case List.head event.images of
        Nothing ->
            ""

        Just image ->
            image.url
