module Types exposing (..)

import Http
import Api.TicketMaster as TicketMaster
import Api.YouTube as YouTube
import Time
import ISO8601


type Msg
    = Init Time.Time
    | InitFail String  -- Getting Date can't fail, so this won't happen
    | SearchDone TicketMaster.Response
    | SearchFail Http.Error
    | YouTubeSuccess Int YouTube.SearchResult
    | YouTubeFail Int Http.Error


type RemoteData e a
    = NotAsked
    | Loading
    | Failure e
    | Success a


type alias WebData a =
    RemoteData Http.Error a


type alias Model =
    { events : WebData TicketMaster.Response
    , videos : List (WebData YouTube.SearchResult)
    , today : ISO8601.Time
    }
