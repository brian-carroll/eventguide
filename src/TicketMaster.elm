module TicketMaster exposing (..)

import Json.Decode exposing (Decoder, string, bool, list, tuple2, int, maybe, (:=))
import Json.Decode.Pipeline exposing (decode, required, requiredAt, optional)
import Date exposing (Date)
import String
import List


type alias Event =
    { name : String
    , type' : String
    , id : String
    , test : Bool
    , url : String
    , locale : String
    , images : List Image
    , sales : Sales
    , dates : EventDates
    , classifications : List Classification
    , promoter : Maybe Promoter
    , info : Maybe String
    , pleaseNote : Maybe String
    , links : Links
    , embedded : Embedded
    }

eventDecoder : Decoder Event
eventDecoder =
    decode Event
        |> required "name" string
        |> required "type" string
        |> required "id" string
        |> required "test" bool
        |> required "url" string
        |> required "locale" string
        |> required "images" (list imageDecoder)
        |> required "sales" salesDecoder
        |> required "dates" eventDatesDecoder
        |> required "classifications" (list classificationDecoder)
        |> optional "promoter" (maybe promoterDecoder) Nothing
        |> optional "info" (maybe string) Nothing
        |> optional "pleaseNote" (maybe string) Nothing
        |> required "_links" linksDecoder
        |> optional "_embedded" embeddedDecoder emptyEmbedded

-------------------------------------------------

type alias Embedded =
    { venues : List Venue
    , attractions : List Attraction
    }

embeddedDecoder : Decoder Embedded
embeddedDecoder =
    decode Embedded
        |> optional "venues" (list venueDecoder) []
        |> optional "attractions" (list attractionDecoder) []

emptyEmbedded : Embedded
emptyEmbedded =
    { venues = []
    , attractions = []
    }

-------------------------------------------------

type alias Attraction =
    { name : String
    , url : String
    , images : List Image
    , classifications : List Classification
    }

attractionDecoder : Decoder Attraction
attractionDecoder =
    decode Attraction
        |> required "name" string
        |> required "url" string
        |> required "images" (list imageDecoder)
        |> required "classifications" (list classificationDecoder)

-------------------------------------------------

type alias Venue =
    { name : String
    , url : String
    , links : Links
    }

venueDecoder : Decoder Venue
venueDecoder =
    decode Venue
        |> required "name" string
        |> required "url" string
        |> required "_links" linksDecoder

-------------------------------------------------

type alias Links =
    { self : String
    , attractions : List String
    , venues : List String
    }

linksDecoder : Decoder Links
linksDecoder =
    decode Links 
        |> required "self" ("href" := string)
        |> optional "attractions" (list ("href" := string)) []
        |> optional "venues" (list ("href" := string)) []
    

-------------------------------------------------

type alias Promoter =
    { id : String
    , name : String
    , description : String
    }

promoterDecoder : Decoder Promoter
promoterDecoder =
    decode Promoter
        |> required "id" string
        |> required "name" string
        |> required "description" string

-------------------------------------------------

type alias Classification =
    { primary : Bool
    , segment : IdAndName
    , genre : IdAndName
    , subGenre : IdAndName
    }

classificationDecoder : Decoder Classification
classificationDecoder =
    decode Classification
        |> required "primary" bool
        |> required "segment" idAndNameDecoder
        |> required "genre" idAndNameDecoder
        |> required "subGenre" idAndNameDecoder

-------------------------------------------------

type alias IdAndName =
    { id : String
    , name : String
    }

idAndNameDecoder : Decoder IdAndName
idAndNameDecoder =
    decode IdAndName
        |> required "id" string
        |> required "name" string

-------------------------------------------------

type alias EventDates =
    { start : EventStartDate
    , timezone : String
    , status : EventStatus
    }

eventDatesDecoder : Decoder EventDates
eventDatesDecoder =
    decode EventDates
        |> required "start" eventStartDateDecoder
        |> required "timezone" string
        |> requiredAt ["status", "code"] eventStatusDecoder


-------------------------------------------------

type alias EventStartDate =
    { localDate : String
    , localTime : String 
    , dateTime : Date
    , dateTBD : Bool
    , dateTBA : Bool
    , timeTBA : Bool
    , noSpecificTime : Bool
    }

eventStartDateDecoder : Decoder EventStartDate
eventStartDateDecoder =
    decode EventStartDate
        |> required "localDate" string
        |> required "localTime" string
        |> required "dateTime" dateDecoder
        |> required "dateTBD" bool
        |> required "dateTBA" bool
        |> required "timeTBA" bool
        |> required "noSpecificTime" bool

-------------------------------------------------

type EventStatus
    = OnSale
    | OffSale
    | Rescheduled
    | Cancelled
    -- | Unknown  -- some other string we didn't expect

eventStatusDecoder : Decoder EventStatus
eventStatusDecoder =
    let
        getResult : String -> Result String EventStatus
        getResult str =
            case str of
                "onsale" -> Ok OnSale
                "offsale" -> Ok OffSale
                "rescheduled" -> Ok Rescheduled
                "cancelled" -> Ok Cancelled
                _ -> Err ("Unknown event status: " ++ str)
    in
        Json.Decode.customDecoder string getResult

-------------------------------------------------

type alias Sales =
    { public : PublicSale
    , presales : List PreSale
    }

salesDecoder : Decoder Sales
salesDecoder =
    decode Sales
        |> required "public" publicSaleDecoder
        |> optional "presales" (list preSaleDecoder) []

-------------------------------------------------

type alias PublicSale = 
    { startDateTime : Date
    , startTBD : Bool
    , endDateTime : Date
    }

publicSaleDecoder : Decoder PublicSale
publicSaleDecoder =
    decode PublicSale
        |> required "startDateTime" dateDecoder
        |> required "startTBD" bool
        |> required "endDateTime" dateDecoder

-------------------------------------------------

type alias PreSale = 
    { startDateTime : Date
    , endDateTime : Date
    , name : String
    }

preSaleDecoder : Decoder PreSale
preSaleDecoder =
    decode PreSale
        |> required "startDateTime" dateDecoder
        |> required "endDateTime" dateDecoder
        |> required "name" string

-------------------------------------------------

type alias Image =
    { ratio: (Int, Int)
    , url: String
    , width: Int
    , height: Int
    , fallback: Bool
    }

imageDecoder : Decoder Image
imageDecoder =
    decode Image
        |> required "ratio" imageRatioDecoder
        |> required "url" string
        |> required "width" int
        |> required "height" int
        |> required "fallback" bool

imageRatioDecoder : Decoder (Int, Int)
imageRatioDecoder =
    let
        getResult : String -> Result String (Int, Int)
        getResult str =
            let
                intResults =
                    String.split "_" str
                        |> List.map String.toInt
            in
                case intResults of
                    (Ok w)::(Ok h)::[] ->
                        Ok (w, h)
                    _ ->
                        Err "Can't decode image width and height"
    in
        Json.Decode.customDecoder string getResult

-------------------------------------------------

dateDecoder : Decoder (Date.Date)
dateDecoder =
    Json.Decode.customDecoder string Date.fromString
