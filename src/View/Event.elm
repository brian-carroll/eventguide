module View.Event exposing (event)

-- External modules

import Html exposing (..)
import Html.Attributes exposing (..)
import Maybe exposing (Maybe)


-- Local modules

import Types exposing (..)
import State exposing (selectClosestImageSize)


event : Event -> Html Msg
event ev =
    let
        ratio =
            ( 16, 9 )

        height =
            115
    in
        div [] <|
            [ divBackgroundImage (selectClosestImageSize ratio height ev.images)
            , h4 [] [ text ev.title ]
            , eventInfo calendarIcon (dateFormat ev.date)
            , eventInfo mapPinIcon ev.venueLocation
            ]


eventInfo icon displayText =
    div [] [ text displayText ]


dateFormat d =
    toString d


calendarIcon =
    div [] []


mapPinIcon =
    div [] []


divBackgroundImage : Maybe Image -> Html Msg
divBackgroundImage maybeImage =
    let
        url =
            case maybeImage of
                Nothing ->
                    ""

                Just img ->
                    img.url

        defaultColor =
            "gray"
    in
        div
            [ style
                [ ( "width", "100%" )
                , ( "height", "100%" )
                , ( "background-image", "url(" ++ url ++ ")" )
                , ( "background-color", defaultColor )
                , ( "background-position-x", "center" )
                , ( "background-position-y", "center" )
                , ( "background-size", "cover" )
                , ( "background-repeat", "no-repeat" )
                ]
            ]
            [ text <| "URL: " ++ url ]



-- center center cover no-repeat"
