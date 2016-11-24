module Types exposing (..)

import Http
import Api.TicketMaster as TicketMaster
import Api.YouTube as YouTube
import Time
import Date
import Dict exposing (Dict)


type Msg
    = Init Time.Time
    | SearchDone (Result Http.Error TicketMaster.Response)
    | YouTubeResult String (Result Http.Error YouTube.SearchResult)
    | ChangeStartTime String
    | ChangeEndTime String


type RemoteData e a
    = NotAsked
    | Loading
    | Failure e
    | Success a


type alias WebData a =
    RemoteData Http.Error a


type alias Model =
    { events : WebData TicketMaster.Response
    , videos : Dict String (WebData YouTube.SearchResult)
    , startTime : Time.Time
    , endTime : Time.Time
    }
