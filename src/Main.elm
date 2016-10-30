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
import Dict exposing (Dict)


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
      , videos = Dict.empty
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
            let
                ( updatedVideoDict, fetchVideosCmd ) =
                    generateVideoQueries response model.videos
            in
                ( { model
                    | events = Success response
                    , videos = updatedVideoDict
                }
                , fetchVideosCmd
                )

        YouTubeFail searchTerm err ->
            ( { model
                | videos =
                    Dict.insert searchTerm (Failure err) model.videos
            }
            , Cmd.none
            )

        YouTubeSuccess searchTerm data ->
            ( { model
                | videos =
                    Dict.insert searchTerm (Success data) model.videos
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


generateVideoQueries : TicketMaster.Response -> Dict String (WebData a) -> (Dict String (WebData a), Cmd Msg)
generateVideoQueries response videoDict =
    let
        newSearchTerms =
            response.events
                |> List.map .name
                |> List.filter (\name -> not (Dict.member name videoDict))

        addLoadingItemToDict : String -> Dict String (WebData a) -> Dict String (WebData a)
        addLoadingItemToDict searchTerm dict =
            Dict.insert searchTerm Loading dict

        updatedVideoDict =
            List.foldl addLoadingItemToDict videoDict newSearchTerms

        command =
            Platform.Cmd.batch (List.map fetchVideos newSearchTerms)
    in
        (updatedVideoDict, command)


fetchVideos : String -> Cmd Msg
fetchVideos searchTerm =
    let
        genFailMsg : Http.Error -> Msg
        genFailMsg err =
            YouTubeFail searchTerm err

        genSuccessMsg : YouTube.SearchResult -> Msg
        genSuccessMsg result =
            YouTubeSuccess searchTerm result
    in
        Http.get YouTube.decodeSearchResult (YouTube.searchUrl searchTerm)
            |> Task.perform genFailMsg genSuccessMsg
