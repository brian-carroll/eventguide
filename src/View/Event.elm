module View.Event exposing (event)

-- External modules

import Html exposing (..)
import Html.Attributes exposing (style)
import Maybe exposing (Maybe)
import Date exposing (Date)
import Html.CssHelpers


-- Local modules

import Types exposing (..)
import State exposing (selectClosestImageSize)
import View.Icons as Icons
import Styles.Selectors exposing (..)


{ id, class, classList } =
    Html.CssHelpers.withNamespace ""


event : Event -> Html Msg
event ev =
    let
        ratio =
            ( 16, 9 )

        cardHeight =
            250
    in
        div
            [ class [ Card ] ]
            [ div [ class [ CardCover ] ]
                [ div [ class [ BgOverlay, BgOverlay_Dark, BgOverlay_25 ] ] []
                , divBackgroundImage (selectClosestImageSize ratio cardHeight ev.images)
                ]
            , div [ class [ CardBody ] ]
                [ h2 [ class [ CardHeading ] ] [ text ev.title ]
                , eventInfo Icons.calendar (dateFormat ev.date)
                , eventInfo Icons.mapPin ev.venueLocation
                ]
            ]


eventInfo : Html msg -> String -> Html msg
eventInfo icon displayText =
    div []
        [ icon
        , text displayText
        ]


dateFormat : Date -> String
dateFormat d =
    let
        h24 =
            Date.hour d

        h12 =
            h24 % 12

        ampm =
            if h24 < 12 then
                "am"
            else
                "pm"

        minuteString =
            case Date.minute d of
                0 ->
                    ""

                m ->
                    toString m
                        |> String.append "0"
                        |> String.right 2
                        |> String.append ":"
    in
        String.concat
            [ toString <| Date.dayOfWeek d
            , " "
            , toString <| Date.day d
            , " "
            , toString <| Date.month d
            , ", "
            , toString h12
            , minuteString
            , ampm
            ]


divBackgroundImage : Maybe Image -> Html Msg
divBackgroundImage maybeImage =
    let
        url =
            Maybe.map .url maybeImage
                |> Maybe.withDefault ""

        defaultColor =
            "gray"
    in
        div [ class [ CardImage ] ]
            [ div
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
                []
            ]
