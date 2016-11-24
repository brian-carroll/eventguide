module Api.TicketMaster exposing (..)

import Json.Decode exposing (Decoder, string, bool, list, int, maybe, field, map)
import Json.Decode.Pipeline exposing (decode, required, requiredAt, optional)
import Date exposing (Date)
import String
import List
import Http


apiParams : List String
apiParams =
    [ "apikey"
      -- API authorization key
      --
      ---- Useful user inputs ----
      --
    , "keyword"
      -- A string to search against event's name. Partial word will not be found. ex:keyword=Mado will not find event with name: Madonna
    , "startDateTime"
      -- Include events happening after this date. Default=2017-01-01T00:00:00Z
    , "endDateTime"
      -- Include events happening before this date. Default=2017-01-01T00:00:00Z
    , "city"
      -- city
    , "radius"
      -- The radius of the area in which we want to search for events. Default=25
    , "unit"
      -- The radius distance unit. Possible values: miles, km. Default=miles
      --
      ---- Fixed or hidden values ----
      --
    , "countryCode"
      -- ISO value. Possible values are: 'US', 'CA', 'AU', 'NZ', 'MX'. Default=MX
    , "latlong"
      -- The Latitude, Longitude coordinates for venue Default=34.0928090,-118.3286610
    , "size"
      -- The number of events returned in the API response. (Max 500) Default=10
    , "page"
      -- The page for paginating through the results. Default=1
    , "sort"
      -- Values: "", "eventDate,date.desc", "eventDate,date.asc", "name,date.desc", "name,date.asc".
    , "source"
      -- Source of the event. Possible values are 'ticketmaster', 'frontgate', 'universe'. Default=ticketmaster
    , "onsaleStartDateTime"
      -- Include events going onsale after this date. Default=2017-01-01T00:00:00Z
    , "onsaleEndDateTime"
      -- Include events going onsale before this date. Default=2017-01-01T00:00:00Z
      --
      ---- Less-useful stuff ----
      --
    , "attractionId"
      -- Attraction ID(s) separated by comma. Default=K8vZ91713eV
    , "venueId"
      -- Venue ID(s) separated by comma. Default=KovZpZAEdFtJ
    , "locale"
      -- There is no fallback mechanism, so it's possible you will not have values in multi-lingual fields
    , "marketId"
      -- The city/metro area in which this event takes place. Default=27
    , "includeTBA"
      -- Whether or not to return events with dates to be announced (TBA). yes|no|only Default=no
    , "includeTBD"
      -- Whether or not to return events with dates to be determined (TBD). yes|no|only  Default=no
    , "includeTest"
      -- Whether or not to return test events. Yes|no|only Default=no
    , "stateCode"
      -- stateCode
    , "classificationName"
      -- any classification name - segment - genre - sub-genre
    , "classificationId"
      -- any classification id - segment - genre - sub-genre
    , "dmaId"
      -- dmaId
    , "postalCode"
      -- Zipcode or Postal Code of the venue in which the event is taking place. This is text-based search, not location-based search. Use lat/long + radius search for nearby events. Default=90069
    ]


searchUrl : List ( String, String ) -> String
searchUrl params =
    let
        path =
            "https://app.ticketmaster.com/discovery/v2/events.json"

        query =
            ( "apikey", "NYrUsoA13JfOGY9EnD7ZT1TGNZAL9IBu" ) :: params

        queryString =
            query
                |> List.map (\( k, v ) -> k ++ "=" ++ (Http.encodeUri v))
                |> String.join "&"
    in
        path ++ "?" ++ queryString


{-| Format date as ISO8601 without timezone ("2016-11-23T23:07:30Z")
-}
dateFormat : Date.Date -> String
dateFormat d =
    let
        monthTwoDigitString =
            case Date.month d of
                Date.Jan ->
                    "01"

                Date.Feb ->
                    "02"

                Date.Mar ->
                    "03"

                Date.Apr ->
                    "04"

                Date.May ->
                    "05"

                Date.Jun ->
                    "06"

                Date.Jul ->
                    "07"

                Date.Aug ->
                    "08"

                Date.Sep ->
                    "09"

                Date.Oct ->
                    "10"

                Date.Nov ->
                    "11"

                Date.Dec ->
                    "12"

        twoDigits a =
            String.right 2 ("0" ++ toString a)
    in
        toString (Date.year d)
            ++ "-"
            ++ monthTwoDigitString
            ++ "-"
            ++ twoDigits (Date.day d)
            ++ "T"
            ++ twoDigits (Date.hour d)
            ++ ":"
            ++ twoDigits (Date.minute d)
            ++ ":"
            ++ twoDigits (Date.second d)
            ++ "Z"



-------------------------------------------------


eventSearchTerm : Event -> String
eventSearchTerm event =
    let
        attractionName =
            case List.head event.embedded.attractions of
                Just attraction ->
                    attraction.name

                Nothing ->
                    event.name

        cleanup s =
            case s of
                "Undefined" ->
                    ""

                _ ->
                    s

        classification =
            case List.head event.classifications of
                Just c ->
                    [ c.segment.name, c.genre.name, c.subGenre.name ]
                        |> List.map cleanup
                        |> String.join " "

                Nothing ->
                    ""
    in
        "\"" ++ attractionName ++ "\" " ++ classification



-------------------------------------------------


type alias Response =
    { events : List Event
    , page : Page
    }


responseDecoder : Decoder Response
responseDecoder =
    decode Response
        |> requiredAt [ "_embedded", "events" ] (list eventDecoder)
        |> required "page" pageDecoder



-------------------------------------------------


type alias Page =
    { size : Int
    , totalElements : Int
    , totalPages : Int
    , number : Int
    }


pageDecoder : Decoder Page
pageDecoder =
    decode Page
        |> required "size" int
        |> required "totalElements" int
        |> required "totalPages" int
        |> required "number" int



-------------------------------------------------


type alias EventId =
    String


eventIdDecoder : Decoder EventId
eventIdDecoder =
    string


type alias Event =
    { name : String
    , type_ : String
    , id : EventId
    , test : Bool
    , url : String
    , locale : String
    , images : List Image
    , sales : Maybe Sales
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
        |> required "id" eventIdDecoder
        |> required "test" bool
        |> required "url" string
        |> required "locale" string
        |> required "images" (list imageDecoder)
        |> optional "sales" (maybe salesDecoder) Nothing
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
        |> required "self" (field "href" string)
        |> optional "attractions" (list (field "href" string)) []
        |> optional "venues" (list (field "href" string)) []



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
        |> requiredAt [ "status", "code" ] eventStatusDecoder



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
    | Postponed
    | Cancelled



-- | Unknown  -- some other string we didn't expect


eventStatusDecoder : Decoder EventStatus
eventStatusDecoder =
    string
        |> Json.Decode.andThen
            (\str ->
                case str of
                    "onsale" ->
                        Json.Decode.succeed OnSale

                    "offsale" ->
                        Json.Decode.succeed OffSale

                    "rescheduled" ->
                        Json.Decode.succeed Rescheduled

                    "postponed" ->
                        Json.Decode.succeed Postponed

                    "cancelled" ->
                        Json.Decode.succeed Cancelled

                    _ ->
                        Json.Decode.fail ("Unknown event status: " ++ str)
            )



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
    { startDateTime : Maybe Date
    , startTBD : Bool
    , endDateTime : Maybe Date
    }


publicSaleDecoder : Decoder PublicSale
publicSaleDecoder =
    decode PublicSale
        |> optional "startDateTime" (maybe dateDecoder) Nothing
        |> required "startTBD" bool
        |> optional "endDateTime" (maybe dateDecoder) Nothing



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
    { ratio : ( Int, Int )
    , url : String
    , width : Int
    , height : Int
    , fallback : Bool
    }


imageDecoder : Decoder Image
imageDecoder =
    decode Image
        |> required "ratio" imageRatioDecoder
        |> required "url" string
        |> required "width" int
        |> required "height" int
        |> required "fallback" bool


imageRatioDecoder : Decoder ( Int, Int )
imageRatioDecoder =
    string
        |> Json.Decode.andThen
            (\str ->
                let
                    intResults =
                        String.split "_" str
                            |> List.map String.toInt
                in
                    case intResults of
                        [ Ok w, Ok h ] ->
                            Json.Decode.succeed ( w, h )

                        _ ->
                            Json.Decode.fail "Can't decode image width and height"
            )



-------------------------------------------------


dateDecoder : Decoder Date.Date
dateDecoder =
    string
        |> Json.Decode.andThen
            (\s ->
                case Date.fromString s of
                    Ok d ->
                        Json.Decode.succeed d

                    Err e ->
                        Json.Decode.fail e
            )



-------------------------------------------------


{-| Pick the best available image, given target aspect ratio and height.
Intended for use with "background-image" and "background-size: cover"
1st priority: pick the closest aspect ratio, to avoid clipping if possible
2nd priority: pick the smallest image that's big enough to cover the target area
-}
selectImageUrl : ( Int, Int ) -> Int -> List Image -> String
selectImageUrl ratio height imageList =
    let
        targetRatio =
            toFloat (Tuple.first ratio) / toFloat (Tuple.second ratio)

        width =
            (ceiling ((toFloat height) * targetRatio))

        selectBetterOfTwoImages : Image -> Image -> Image
        selectBetterOfTwoImages nextImage bestImage =
            let
                ratioDiff img =
                    abs ((toFloat (Tuple.first img.ratio) / toFloat (Tuple.second img.ratio)) - targetRatio)

                ratioDiffComparison =
                    compare (ratioDiff nextImage) (ratioDiff bestImage)

                bestCoversTarget =
                    (bestImage.width >= width) && (bestImage.height >= height)

                nextCoversTarget =
                    (nextImage.width >= width) && (nextImage.height >= height)
            in
                case ratioDiffComparison of
                    LT ->
                        nextImage

                    GT ->
                        bestImage

                    EQ ->
                        if bestCoversTarget then
                            -- Big enough to cover the target element => pick the smallest
                            (if (nextImage.width < bestImage.width) && nextCoversTarget then
                                nextImage
                             else
                                bestImage
                            )
                        else
                            -- Too small to cover the target element => pick the biggest
                            (if nextImage.width > bestImage.width then
                                nextImage
                             else
                                bestImage
                            )
    in
        case imageList of
            [] ->
                ""

            h :: t ->
                .url (List.foldl selectBetterOfTwoImages h t)
