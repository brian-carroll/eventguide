module View.Icons exposing (..)

import Html exposing (Html)
import Svg exposing (..)
import Svg.Attributes exposing (..)


calendar : Html msg
calendar =
    svg
        [ width "18"
        , height "18"
        , viewBox "0 0 18 18"
        ]
        [ g [ fill "none", fillRule "evenodd" ]
            [ rect [ fill "currentColor", x "5", y "8", width "2", height "2", rx ".5" ] []
            , rect [ fill "currentColor", x "8", y "8", width "2", height "2", rx ".5" ] []
            , rect [ fill "currentColor", x "11", y "8", width "2", height "2", rx ".5" ] []
            , rect [ fill "currentColor", x "11", y "11", width "2", height "2", rx ".5" ] []
            , rect [ fill "currentColor", x "8", y "11", width "2", height "2", rx ".5" ] []
            , rect [ fill "currentColor", x "5", y "11", width "2", height "2", rx ".5" ] []
            , rect [ stroke "currentColor", x "2.5", y "2.5", width "13", height "13", rx ".01" ] []
            , Svg.path [ d "M4.5 5.5h9", stroke "currentColor", strokeLinecap "round" ] []
            ]
        ]


mapPin : Html msg
mapPin =
    svg [ width "18", height "18", viewBox "0 0 18 18" ]
        [ g [ fill "none", fillRule "evenodd" ]
            [ Svg.path
                [ d "M9 16.5s6-6.084 6-9.167C15 4.072 12.314 1.5 9 1.5S3 4.072 3 7.333C3 10.416 9 16.5 9 16.5z"
                , stroke "currentColor"
                , strokeWidth "1.2"
                ]
                []
            , ellipse
                [ fill "currentColor", cx "9", cy "7.5", rx "1.5", ry "1.5" ]
                []
            ]
        ]
