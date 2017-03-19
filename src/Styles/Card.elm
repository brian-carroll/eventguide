module Styles.Card exposing (css)

import Css exposing (..)
import Styles.Selectors exposing (..)


css : Stylesheet
css =
    stylesheet
        [ mediaQuery "only screen and (min-width: 480px)"
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
        , class CardList
            [ descendants
                [ class Card
                    [ display inlineBlock
                    , marginBottom (px 32)
                    ]
                ]
            ]
        ]



{-
   .card {
     vertical-align: top;
     width: 100%;
     border-radius: 2px;
     overflow: hidden;
     backface-visibility: hidden;
     text-rendering: optimizeLegibility;
     transform: translateZ(0);
     &:hover {
       .bg-overlay {
         opacity: 0;
       }
     }
     .bg-overlay {
       z-index: 1;
     }
     .btn--play {
       position: absolute;
       top: 50%;
       left: 50%;
       background-color: rgba($asphalt-m,0.5);
       transform: translate(-50%,-50%) scale(0.8);
     }
   }

   .card.card--empty {
     margin-top: 32px;
     margin-bottom: 32px;
     .card__cover {
       background-color: transparent;
       border: 3px dashed $grey-l;
       border-radius: 2px;
       transition: all 0.3s $cubic;
     }
     .card__cta {
       position: absolute;
       bottom: 0;
       margin: 0;
       width: 100%;
       padding: 12px;
       color: $brand-primary;
       text-align: center;
       text-transform: uppercase;
       font-size: 0.9rem;
     }
     .btn--play {
       font-size: 60px;
       line-height: 95px;
       background-color: transparent;
       border-color: $grey-l;
       color: $grey-l;
     }
     &:hover {
       .card__cover {
         border-color: rgba($asphalt-l,0.75);
       }
     }
   }

   .card__cover {
     position: relative;
     background-color: $grey-l;
     background-size: cover;
     background-position: center center;
     background-repeat: no-repeat;
     backface-visibility: hidden;
     overflow: hidden;
     //border-bottom: 1px solid $grey-l;
     &:after {
       display: block;
       content: "";
       width: 100%;
       padding-top: 56.25%;
     }
     .badge {
       position: absolute;
       z-index: 5;
       top: 16px;
       right: 24px;
       border-color: $white;
       background-color: rgba($asphalt-m,0.5);
       color: $white;
       backface-visibility: hidden;
     }
   }

   .card__price {
     display: block;
     position: absolute;
     z-index: 6;
     bottom: 16px;
     right: 24px;
     padding: 4px 12px;
     border: 1px solid $white;
     border-radius: 30px;
     background-color: rgba($asphalt-m,0.5);
     color: $white;
     backface-visibility: hidden;
   }

   .card__heading {
     margin: 0.5rem 0;
     font-weight: 700;
   }

   .card__sub-heading {
     margin-bottom: 0;
     font-family: $body-font;
     font-weight: 400;
     font-size: 0.9rem;
     color: $grey-m;
     text-transform: capitalize;
   }

   .card__image {
     position: absolute;
     top: 0;
     left: 0;
     right: 0;
     bottom: 0;
     width: 100%;
   }

-}
