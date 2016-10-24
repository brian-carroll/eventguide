module Main exposing (main)

{-| Event guide with imported content on listed events
@docs main
-}

-- External modules
--import Html.App as App

import TimeTravel.Html.App as App
import Task
import Http
import Dict
import Platform.Cmd exposing (Cmd)


-- Local modules

import Api.TicketMaster as TicketMaster
import Api.YouTube as YouTube
import Types exposing (..)
import View


{-| Entry point for the app
-}
main : Program Never
main =
    App.program
        { init = init
        , update = update
        , subscriptions = (\_ -> Sub.none)
        , view = View.root
        }


init : ( Model, Cmd Msg )
init =
    ( { events = Loading, videos = Dict.empty }
    , fetchEvents
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SearchFail e ->
            ( { model
                | events =
                    Failure e
              }
            , Cmd.none
            )

        SearchDone response ->
            ( { model
                | events =
                    Success response
              }
            , Cmd.batch (generateVideoQueries response)
            )

        YouTubeSuccess eventId youtubeSearchResult ->
            ( { model
                | videos =
                    Dict.insert eventId (Success youtubeSearchResult) model.videos
              }
            , Cmd.none
            )

        YouTubeFail eventId e ->
            ( { model
                | videos =
                    Dict.insert eventId (Failure e) model.videos
              }
            , Cmd.none
            )


fetchEvents : Cmd Msg
fetchEvents =
    let
        params =
            [ ( "city", "london" )
            , ( "countryCode", "gb" )
            , ( "classificationName", "music" )
            ]
    in
        Http.get TicketMaster.responseDecoder (TicketMaster.searchUrl params)
            |> Task.perform SearchFail SearchDone


generateVideoQueries : TicketMaster.Response -> List (Cmd Msg)
generateVideoQueries response =
    response.events
        |> List.map (\e -> fetchVideos ( e.id, e.name ))


fetchVideos : ( TicketMaster.EventId, String ) -> Cmd Msg
fetchVideos ( eventId, searchTerm ) =
    let
        genFailMsg : Http.Error -> Msg
        genFailMsg err =
            YouTubeFail eventId err

        genSuccessMsg : YouTube.SearchResult -> Msg
        genSuccessMsg result =
            YouTubeSuccess eventId result
    in
        Http.get YouTube.decodeSearchResult (YouTube.searchUrl searchTerm)
            |> Task.perform genFailMsg genSuccessMsg
