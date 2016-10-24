module Types exposing (..)

import Http
import Api.TicketMaster as TicketMaster


type Msg
    = SearchDone TicketMaster.Response
    | SearchFail Http.Error


type RemoteData e a
    = NotAsked
    | Loading
    | Failure e
    | Success a


type alias WebData a =
    RemoteData Http.Error a


type alias Model =
    { data : WebData TicketMaster.Response
    }
