module Styles.BgOverlay exposing (css)

import Css exposing (..)
import Styles.Selectors exposing (..)
import Styles.Constants exposing (asphaltM, asphaltL, cubic)


css =
    stylesheet
        [ class BgOverlay
            [ position absolute
            , top zero
            , right zero
            , bottom zero
            , left zero
            , property "transition" <| "all 0.3s " ++ cubic
            , backgroundColor asphaltM
            ]
          -- , class BgOverlay_Dark
          -- [ @include gradient(asphaltL,asphaltM)
          -- ]
        , class BgOverlay_Video
            [ backgroundImage (url "/media/img/icon-play.png")
            , backgroundRepeat noRepeat
            , backgroundPosition2 (pct 50) (pct 50)
            , backgroundSize (pct 15)
            ]
        , class BgOverlay_75
            [ opacity (num 0.75)
            ]
        , class BgOverlay_50
            [ opacity (num 0.5)
            ]
        , class BgOverlay_25
            [ opacity (num 0.25)
            ]
        ]
