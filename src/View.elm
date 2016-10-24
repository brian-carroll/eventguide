module View exposing (root)

-- External modules

import Html exposing (..)
import Html.Attributes exposing (..)


-- Local modules

import Types exposing (..)
import Api.TicketMaster as TicketMaster


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
            div [ class "container-fluid" ]
                (List.map tmevent data.events)


tmevent : TicketMaster.Event -> Html Msg
tmevent event =
    div [ class "row" ]
        [ a [ href event.url ]
            [ h3 []
                [ text event.name ]
            ]
        , div [ class "row" ]
            [ div [ class "col-md-6" ]
                [ img [ src (getEventImageUrl event) ] []
                ]
            , div [ class "col-md-6" ]
                [ img [ src (getEventImageUrl event) ] []
                ]
            ]
        ]


getEventImageUrl : TicketMaster.Event -> String
getEventImageUrl event =
    let
        ratio =
            ( 16, 9 )

        height =
            115
    in
        TicketMaster.selectImageUrl ratio height event.images
