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
    ( { events = Loading
      , videos = []
      , startDate = ISO8601.fromTime 0
      , endDate = ISO8601.fromTime 0
      }
    , Task.perform InitFail Init Time.now
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Init nowTimeStamp ->
            let
                days =
                    14

                nowNearestSecond =
                    (1000 * round (nowTimeStamp / 1000))

                start =
                    ISO8601.fromTime nowNearestSecond

                end =
                    ISO8601.fromTime (nowNearestSecond + (days * 24 * round Time.hour))
            in
                ( { model
                    | startDate = start
                    , endDate = end
                  }
                , fetchEvents start end
                )

        InitFail _ ->
            -- Never executed, since Time.now always succeeds
            ( model, Cmd.none )

        SearchFail e ->
            ( { model
                | events =
                    Failure e
              }
            , Cmd.none
            )

        SearchDone response ->
            ( { model
                | events = Success response
                , videos = List.repeat (List.length response.events) Loading
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

        ChangeStartDate s ->
            case ISO8601.fromString s of
                Ok d ->
                    ( { model | startDate = d }
                    , fetchEvents d model.endDate
                    )

                Err _ ->
                    ( model, Cmd.none )

        ChangeEndDate s ->
            case ISO8601.fromString s of
                Ok d ->
                    ( { model | endDate = d }
                    , fetchEvents model.startDate d
                    )

                Err _ ->
                    ( model, Cmd.none )


listReplace : Int -> a -> List a -> List a
listReplace index item list =
    List.concat
        [ List.take index list
        , [ item ]
        , List.drop (index + 1) list
        ]


fetchEvents : ISO8601.Time -> ISO8601.Time -> Cmd Msg
fetchEvents start end =
    let
        url =
            TicketMaster.searchUrl
                [ ( "city", "london" )
                , ( "countryCode", "gb" )
                , ( "size", toString 10 )
                , ( "classificationName", "music" )
                , ( "startDateTime", ISO8601.toString start )
                , ( "endDateTime", ISO8601.toString end )
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
