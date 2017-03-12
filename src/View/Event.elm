module View.Event exposing (event)

-- External modules

import Html exposing (..)
import Html.Attributes exposing (..)
import Maybe exposing (Maybe)


-- Local modules

import Types exposing (..)
import State exposing (selectClosestImageSize)
import View.Icons as Icons


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
            , eventInfo Icons.calendar (dateFormat ev.date)
            , eventInfo Icons.mapPin ev.venueLocation
            ]


eventInfo icon displayText =
    div []
        [ icon
        , text displayText
        ]


dateFormat d =
    toString d


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
