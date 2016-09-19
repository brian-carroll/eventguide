module Main exposing (main)

-- External modules
--import Html.App as App
import TimeTravel.Html.App as App
import Task
import Http

-- Local modules
import TicketMaster
import Types exposing (..)
import View


fetchEvents : Cmd Msg
fetchEvents =
    Http.get TicketMaster.responseDecoder searchUrl
        |> Task.perform SearchFail SearchDone


searchUrl : String
searchUrl =
    "https://app.ticketmaster.com/discovery/v2/events.json?city=london&countryCode=gb&classificationName=music{&page,size,sort}&apikey=NYrUsoA13JfOGY9EnD7ZT1TGNZAL9IBu"



init : (Model, Cmd Msg)
init = 
    ({ data = NotAsked }, fetchEvents)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SearchFail e ->
            ( { data = Failure e }, Cmd.none )

        SearchDone response ->
            ( { data = Success response }, Cmd.none )



main : Program Never
main =
  App.program
    { init = init
    , update = update
    , subscriptions = (\_ -> Sub.none)
    , view = View.root
    }
