module Styles.Card exposing (css)

import Css exposing (..)
import Styles.Selectors exposing (..)
import Styles.Constants exposing (white, greyL, greyM, asphaltL, asphaltM)


css : Stylesheet
css =
    stylesheet
        [ class CardList
            [ maxWidth (px 1200)
            , margin auto
            , descendants
                [ class Card
                    [ display inlineBlock
                    , marginBottom (px 32)
                    ]
                ]
            ]
        , class Card
            [ verticalAlign top
            , width (pct 100)
            , borderRadius (px 2)
            , overflow hidden
              -- , backfaceVisibility hidden
            , textRendering optimizeLegibility
            , transform <| translateZ zero
            , hover
                [ descendants
                    [ class BgOverlay
                        [ opacity zero
                        ]
                    ]
                ]
            ]
        , mediaQuery "only screen and (min-width: 480px)"
            [ class CardList
                [ padding2 zero (px 48)
                ]
            ]
        , mediaQuery "only screen and (min-width: 480px)"
            [ class Card
                [ margin4 (px 16) (px 14) (px 40) (px 14)
                , property "width" "calc(100% / 2 - 32px)"
                ]
            ]
        , mediaQuery "only screen and (min-width: 800px)"
            [ class Card
                [ property "width" "calc(100% / 3 - 32px)"
                ]
            ]
        , class BgOverlay
            [ zIndex (int 1)
            ]
        , class BtnPlay
            [ position absolute
            , top (pct 50)
            , left (pct 50)
            , backgroundColor asphaltM
            , transforms [ translate2 (pct -50) (pct -50), (scale 0.8) ]
            ]
          -- , class CardEmpty
          --     [ marginTop (px 32)
          --     , marginBottom (px 32)
          --     , descendants
          --         [ class CardCover
          --             [ backgroundColor transparent
          --             , border (px 3) dashed greyL
          --             , borderRadius (px 2)
          --             , transition all 0.3 s cubic
          --             ]
          --         , class CardCta
          --             [ position absolute
          --             , bottom 0
          --             , margin 0
          --             , width (pct 100)
          --             , padding (px 12)
          --             , color brandprimary
          --             , textAlign center
          --             , textTransform uppercase
          --             , fontSize (Css.rem 0.9)
          --             ]
          --         , class BtnPlay
          --             [ fontSize (px 60)
          --             , lineHeight (px 95)
          --             , backgroundColor transparent
          --             , borderColor greyL
          --             , color greyL
          --             ]
          --         , hover
          --             [ descendants
          --                 [ CardCover
          --                     [ borderColor asphaltL
          --                     ]
          --                 ]
          --             ]
          --         ]
          --     ]
        , class CardCover
            [ position relative
            , height (px 250)
            , backgroundColor greyL
            , backgroundSize cover
            , property "background-position" "center center"
            , backgroundRepeat noRepeat
              -- , backfaceVisibility hidden
            , overflow hidden
            , after
                [ display block
                , property "content" ""
                , width (pct 100)
                , paddingTop (pct 56.25)
                ]
            ]
          -- , class CardPrice
          --     [ display block
          --     , position absolute
          --     , zIndex 6
          --     , bottom (px 16)
          --     , right (px 24)
          --     , padding (px 4) (px 12)
          --     , border (px 1) solid white
          --     , borderRadius (px 30)
          --     , backgroundColor asphaltM
          --     , color white
          --       -- , backfaceVisibility hidden
          --     ]
        , class CardHeading
            [ margin2 (Css.rem 0.5) zero
            , fontWeight (int 700)
            ]
          -- , class CardSubHeading
          --     [ marginBottom 0
          --     , fontFamily bodyfont
          --     , fontWeight 400
          --     , fontSize (Css.rem 0.9)
          --     , color greyM
          --     , textTransform capitalize
          --     ]
        , class CardImage
            [ position absolute
            , top zero
            , left zero
            , right zero
            , bottom zero
            , width (pct 100)
            ]
        ]
