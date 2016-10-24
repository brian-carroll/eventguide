module Types exposing (..)

import Http
import Api.TicketMaster as TicketMaster
import Api.YouTube as YouTube
import Dict exposing (Dict)


type Msg
    = SearchDone TicketMaster.Response
    | SearchFail Http.Error
    | YouTubeSuccess TicketMaster.EventId YouTube.SearchResult
    | YouTubeFail TicketMaster.EventId Http.Error


type RemoteData e a
    = NotAsked
    | Loading
    | Failure e
    | Success a


type alias WebData a =
    RemoteData Http.Error a


type alias Model =
    { events : WebData TicketMaster.Response
    , videos : Dict TicketMaster.EventId (WebData YouTube.SearchResult)
    }
