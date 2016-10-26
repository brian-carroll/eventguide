module Main exposing (main)

{-| Event guide with imported content on listed events
@docs main
-}

-- External modules
-- import Html.App as App
import TimeTravel.Html.App as App

import Task
import Http
import Platform.Cmd exposing (Cmd)
import ISO8601
import Time


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
    ( { events = Loading, videos = [], today = ISO8601.fromTime 0 }
    , Task.perform InitFail Init Time.now
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Init now ->
            let
                t =
                    ISO8601.fromTime (1000 * round (now/1000))
            in
                ( { model | today = t }
                , fetchEvents t
                )

        SearchFail e ->
            ( { model
                | events =
                    Failure e
              }
            , Cmd.none
            )

        SearchDone response ->
            ( { events = Success response
              , videos = List.repeat (List.length response.events) Loading
              , today = model.today
              }
            , Cmd.batch (generateVideoQueries response)
            )

        YouTubeFail index err ->
            ( { model
                | videos =
                    listReplace index (Failure err) model.videos
              }
            , Cmd.none
            )

        YouTubeSuccess index youtubeSearchResult ->
            ( { model
                | videos =
                    listReplace index (Success youtubeSearchResult) model.videos
              }
            , Cmd.none
            )

        _ ->
            ( model, Cmd.none )


listReplace : Int -> a -> List a -> List a
listReplace index item list =
    List.concat
        [ List.take index list
        , [ item ]
        , List.drop (index + 1) list
        ]


fetchEvents : ISO8601.Time -> Cmd Msg
fetchEvents today =
    let
        days =
            14

        endDateTime =
            today
                |> ISO8601.toTime
                |> (+) ( days * 24 * round Time.hour )
                |> ISO8601.fromTime

        url =
            TicketMaster.searchUrl
                [ ( "city", "london" )
                , ( "countryCode", "gb" )
                , ( "size", toString 10 )
                , ( "classificationName", "music" )
                , ( "startDateTime", ISO8601.toString today )
                , ( "endDateTime", ISO8601.toString endDateTime )
                ]
    in
        Http.get TicketMaster.responseDecoder url
            |> Task.perform SearchFail SearchDone


generateVideoQueries : TicketMaster.Response -> List (Cmd Msg)
generateVideoQueries response =
    response.events
        |> List.indexedMap (\index event -> fetchVideos index event.name)


fetchVideos : Int -> String -> Cmd Msg
fetchVideos index searchTerm =
    let
        genFailMsg : Http.Error -> Msg
        genFailMsg err =
            YouTubeFail index err

        genSuccessMsg : YouTube.SearchResult -> Msg
        genSuccessMsg result =
            YouTubeSuccess index result
    in
        Http.get YouTube.decodeSearchResult (YouTube.searchUrl searchTerm)
            |> Task.perform genFailMsg genSuccessMsg
