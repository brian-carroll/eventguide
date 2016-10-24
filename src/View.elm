module View exposing (root)

-- External modules

import Html exposing (..)
import Html.Attributes exposing (..)


-- Local modules

import Types exposing (..)
import Api.TicketMaster as TicketMaster
import Api.YouTube as YouTube


root : Model -> Html Msg
root model =
    div []
        [ h1 [] [text "Brian's Event Guide"]
        , eventList model
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
            div [ class "container-fluid" ]
                (List.map2 event data.events model.videos)


event : TicketMaster.Event -> (WebData YouTube.SearchResult) -> Html Msg
event ev video =
    div [ class "row" ]
        [ a [ href ev.url ]
            [ h3 [] [ text ev.name ]
            ]
        , div [ class "row" ]
            [ div [ class "col-md-4" ]
                [ img [ src (eventImageUrl ev) ] []
                ]
            , div [ class "col-md-8" ]
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
