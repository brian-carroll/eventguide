module Types exposing (..)

import Http
import Api.TicketMaster as TicketMaster
import Api.YouTube as YouTube
import Time
import Date
import Dict exposing (Dict)


type Msg
    = Init Time.Time
    | InitFail String
    | SearchDone TicketMaster.Response
    | SearchFail Http.Error
    | YouTubeSuccess String YouTube.SearchResult
    | YouTubeFail String Http.Error
    | ChangeStartDate String
    | ChangeEndDate String


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
    , startDate : Time.Time
    , endDate : Time.Time
    }
