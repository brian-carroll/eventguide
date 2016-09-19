module Main exposing (main)

import Html exposing (Html, div, text)
import Html.App as App
import TicketMaster
import Http
import Task


fetchEvents : Cmd Msg
fetchEvents =
    Http.get TicketMaster.responseDecoder searchUrl
        |> Task.perform SearchFail SearchDone


searchUrl : String
searchUrl =
    "https://app.ticketmaster.com/discovery/v2/events.json?city=london&countryCode=gb&classificationName=music{&page,size,sort}&apikey=NYrUsoA13JfOGY9EnD7ZT1TGNZAL9IBu"


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


view : Model -> Html Msg
view model =
    div []
        [ text (toString model)
        ]


main : Program Never
main =
  App.program
    { init = init
    , update = update
    , subscriptions = (\_ -> Sub.none)
    , view = view
    }
