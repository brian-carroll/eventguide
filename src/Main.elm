module Main exposing (main)

{-| Event guide with imported content on listed events
@docs main
-}

-- External modules

import Html
import Task
import Http
import Platform.Cmd exposing (Cmd)
import Date
import Time
import Dict exposing (Dict)


-- Local modules

import Api.TicketMaster as TicketMaster
import Api.YouTube as YouTube
import Types exposing (..)
import View


{-| Entry point for the app
-}
main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = (\_ -> Sub.none)
        , view = View.root
        }


init : ( Model, Cmd Msg )
init =
    ( { events = NotAsked
      , videos = Dict.empty
      , startDate = Date.fromTime 0
      , endDate = Date.fromTime 0
      }
    , Task.perform Init Time.now
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
                    Date.fromTime (toFloat nowNearestSecond)

                end =
                    (nowNearestSecond + (days * 24 * round Time.hour))
                        |> toFloat
                        |> Date.fromTime
            in
                ( { model
                    | events = Loading
                    , startDate = start
                    , endDate = end
                  }
                , fetchEvents start end
                )

        ReceivedEvents (Err e) ->
            ( { model
                | events =
                    Failure e
              }
            , Cmd.none
            )

        ReceivedEvents (Ok response) ->
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

        ReceivedVideos searchTerm (Err e) ->
            ( { model
                | videos =
                    Dict.insert searchTerm (Failure e) model.videos
              }
            , Cmd.none
            )

        ReceivedVideos searchTerm (Ok data) ->
            ( { model
                | videos =
                    Dict.insert searchTerm (Success data) model.videos
              }
            , Cmd.none
            )

        ChangeStartDate s ->
            case Date.fromString s of
                Ok d ->
                    ( { model | startDate = d }
                    , fetchEvents d model.endDate
                    )

                Err _ ->
                    ( model, Cmd.none )

        ChangeEndDate s ->
            case Date.fromString s of
                Ok d ->
                    ( { model | endDate = d }
                    , fetchEvents model.startDate d
                    )

                Err _ ->
                    ( model, Cmd.none )


fetchEvents : Date.Date -> Date.Date -> Cmd Msg
fetchEvents start end =
    let
        url =
            TicketMaster.searchUrl
                [ ( "city", "london" )
                , ( "countryCode", "gb" )
                , ( "size", toString 10 )
                , ( "classificationName", "music" )
                , ( "startDateTime", TicketMaster.dateFormat start )
                , ( "endDateTime", TicketMaster.dateFormat end )
                ]
    in
        Http.send ReceivedEvents <|
            Http.get url TicketMaster.appEventDecoder


generateVideoQueries : List Event -> Dict String (WebData a) -> ( Dict String (WebData a), Cmd Msg )
generateVideoQueries eventList videoDict =
    let
        newSearchTerms =
            eventList
                |> List.map .contentSearchTerm
                |> List.filter (\name -> not (Dict.member name videoDict))

        addLoadingItemToDict : String -> Dict String (WebData a) -> Dict String (WebData a)
        addLoadingItemToDict searchTerm dict =
            Dict.insert searchTerm Loading dict

        updatedVideoDict =
            List.foldl addLoadingItemToDict videoDict newSearchTerms

        command =
            Platform.Cmd.batch (List.map fetchVideos newSearchTerms)
    in
        ( updatedVideoDict, command )


fetchVideos : String -> Cmd Msg
fetchVideos searchTerm =
    Http.send (\vids -> ReceivedVideos searchTerm vids) <|
        Http.get (YouTube.searchUrl searchTerm) YouTube.decodeAppVideoList
