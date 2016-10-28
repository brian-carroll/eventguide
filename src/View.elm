module View exposing (root)

-- External modules

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import ISO8601

-- Local modules

import Types exposing (..)
import Api.TicketMaster as TicketMaster
import Api.YouTube as YouTube


root : Model -> Html Msg
root model =
    div [ class "container" ]
        [ h1 [] [ text "Brian's Event Guide" ]
        , inputForm model
        , eventList model
        ]


inputForm : Model -> Html Msg
inputForm model =
    div []
        [ input
            [ placeholder "Start Date"
            , value (ISO8601.toString model.startDate)
            , onInput ChangeStartDate
            ]
            []
        , input
            [ placeholder "End Date"
            , value (ISO8601.toString model.endDate)
            , onInput ChangeEndDate
            ]
            []
        ]


eventList : Model -> Html Msg
eventList model =
    case model.events of
        NotAsked ->
            text "Request not sent yet"

        Loading ->
            text "Loading..."

        Failure error ->
            text (toString error)

        Success data ->
            div []
                (List.map2 event data.events model.videos)


event : TicketMaster.Event -> WebData YouTube.SearchResult -> Html Msg
event ev video =
    div [ class "row event" ]
        [ h3 [] [ text ev.name ]
        , div [ class "row well" ]
            [ div [ class "col-md-4" ]
                [ img [ src (eventImageUrl ev) ] []
                ]
            , div [ class "col-md-4" ]
                (eventDetails ev)
            , div [ class "col-md-4" ]
                [ iframe
                    [ src (eventVideoUrl video)
                    , width 205
                    , height 115
                    , attribute "frameborder" "0"
                    , attribute "allowfullscreen" ""
                    ]
                    []
                ]
            ]
        ]


eventDetails : TicketMaster.Event -> List (Html Msg)
eventDetails event =
    [ div [ class "row" ]
        [ text (event.dates.start.localDate ++ " " ++ event.dates.start.localTime)
        ]
    , div [ class "row" ]
        (List.map venueLink event.embedded.venues)
    , div [ class "row" ]
        [ a [ class "btn btn-default", href event.url, target "_blank" ]
            [ text "Buy Now"
            ]
        ]
    ]


venueLink : TicketMaster.Venue -> Html Msg
venueLink venue =
    a [ href venue.url, target "_blank" ]
        [ text venue.name ]


eventImageUrl : TicketMaster.Event -> String
eventImageUrl event =
    let
        ratio =
            ( 16, 9 )

        height =
            115
    in
        TicketMaster.selectImageUrl ratio height event.images


eventVideoUrl : WebData YouTube.SearchResult -> String
eventVideoUrl webData =
    let
        firstEmbedUrl : Maybe String
        firstEmbedUrl =
            case webData of
                Success searchResult ->
                    YouTube.getFirstEmbedUrl searchResult

                _ ->
                    Nothing
    in
        Maybe.withDefault "" firstEmbedUrl
