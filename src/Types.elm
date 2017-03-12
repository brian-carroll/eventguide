module Types exposing (..)

import Http
import Time
import Date
import Dict exposing (Dict)


type Msg
    = Init Time.Time
    | ReceivedEvents (Result Http.Error (List Event))
    | ReceivedVideos String (Result Http.Error (List Video))
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
    { events : WebData (List Event)
    , videos : Dict String (WebData (List Video))
    , startDate : Date.Date
    , endDate : Date.Date
    }


type alias Event =
    { images : List Image
    , title : String
    , date : Date.Date
    , venueLocation : String
    , priceX100 : Maybe Int
    , contentSearchTerm : String
    }


{-|
Possible extra fields for Video:
, title : String
, description : String
, thumbnailUrls : List String
-}
type alias Video =
    { url : String
    }


type alias Image =
    { ratio : ( Int, Int )
    , url : String
    , width : Int
    , height : Int
    , fallback : Bool
    }
