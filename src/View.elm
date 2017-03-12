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



{-
   event-list
       event-wrapper
           event (translateY on hover)
               a.event__image
                   image (background)
               event__footer
                   event__info
                       a
                           h4 title
                       event-group-meta-item
                           event-group-meta-item__icon
                           event-group-meta-item__info
                       event-group-meta-item
                           event-group-meta-item__icon
                           event-group-meta-item__info
                   event__price-cta (appears on hover)
                       event__price
                       a.button

   modal__wrapper
       modal__fill
           modal
               modal__header
               modal__body
-}
{-


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
               , value (TicketMaster.dateFormat model.startDate)
               , onInput ChangeStartDate
               ]
               []
           , input
               [ placeholder "End Date"
               , value (TicketMaster.dateFormat model.endDate)
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
                   (List.map (event model.videos) data.events)


   event : Dict String (WebData YouTube.SearchResult) -> TicketMaster.Event -> Html Msg
   event videos ev =
       let
           searchTerm =
               TicketMaster.eventSearchTerm ev

           videoUrl =
               case Dict.get searchTerm videos of
                   Just video ->
                       eventVideoUrl video

                   Nothing ->
                       ""
       in
           div [ class "row event" ]
               [ h3 [] [ text ev.name ]
               , div [ class "row well" ]
                   [ div [ class "col-md-4" ]
                       [ img
                           [ src (eventImageUrl ev)
                           , width 205
                           , height 105
                           ]
                           []
                       ]
                   , div [ class "col-md-4" ]
                       (eventDetails ev)
                   , div [ class "col-md-4" ]
                       [ iframe
                           [ src videoUrl
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

-}
