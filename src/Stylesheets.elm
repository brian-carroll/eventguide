port module Stylesheets exposing (..)

import Css exposing (..)
import Css.File exposing (CssFileStructure, CssCompilerProgram)


port files : CssFileStructure -> Cmd msg


fileStructure : CssFileStructure
fileStructure =
    Css.File.toFileStructure
        [ ( "index.css", Css.File.compile [ css ] ) ]


main : CssCompilerProgram
main =
    Css.File.compiler files fileStructure


type CssClasses
    = EventList
    | EventWrapper
    | Event
    | EventImage
    | EventBody
    | EventInfo
    | EventFooter
    | EventPrice


css : Stylesheet
css =
    stylesheet
        [ class EventWrapper
            [ padding (Css.rem 0.8125)
            , width (pct 100)
            ]
        , mediaQuery "(min-width: 601px)"
            [ Css.class EventWrapper
                [ width (pct 50)
                ]
            ]
        , mediaQuery "(min-width: 961px)"
            [ Css.class EventWrapper
                [ width (pct 33.32)
                ]
            ]
        , class Event
            [ backgroundColor (hex "fff")
            , borderRadius (px 2)
            , boxShadow4 zero (px 1) (px 2) (rgba 0 0 0 0.1)
            , boxShadow4 zero zero (px 2) (rgba 0 0 0 0.1)
            , color (hex "404d57")
            , cursor pointer
            , position relative
            , width (pct 100)
              -- , transition: transform .24s, box-shadow .24s
            , hover
                [ boxShadow4 zero (px 4) (px 6) (rgba 0 0 0 0.1)
                , boxShadow4 zero zero (px 2) (rgba 0 0 0 0.1)
                , transform (translate2 zero (px -4))
                , transform (translateY (px -4))
                ]
            ]
        , class EventImage
            [ borderRadius4 (px 2) (px 2) zero zero
            , display block
            , height (Css.rem 13.75)
            , overflow hidden
            , width (pct 100)
            ]
        ]



{-
     event-list
       event-wrapper
         event (translateY on hover)
             a.event__image
                 image (background)
             event__body
                 event__info
                     a
                         h4 title
                     event-group-meta-item
                         event-group-meta-item__icon
                         event-group-meta-item__info
                     event-group-meta-item
                         event-group-meta-item__icon
                         event-group-meta-item__info
                 event__footer (appears on hover)
                     event__price
                     a.button

   @media (min-width: 601px) {
       .collection-list--three-columns .collection-item {
           width: 50%
       }
       }
    @media (min-width: 961px) {
    .collection-list--three-columns .collection-item {
        width: 33.32%
    }


   .event-group-item {
       background: #fff;
       border-radius: 2px;
       box-shadow: 0 1px 2px rgba(0, 0, 0, .1), 0 0 2px rgba(0, 0, 0, .1);
       color: #404d57;
       cursor: pointer;
       position: relative;
       width: 100%;
       transition: transform .24s, box-shadow .24s
   }
   .event-group-item:hover {
       box-shadow: 0 4px 6px rgba(0, 0, 0, .1), 0 0 2px rgba(0, 0, 0, .1);
       transform: translate(0, -4px);
       transform: translateY(-4px)
   }

   a.event-group-item__image {
       border-radius: 2px 2px 0 0;
       display: block;
       height: 13.75rem;
       overflow: hidden;
       width: 100%
   }
   .event-group-item__footer {
       display: -ms-flexbox;
       display: flex;
       -ms-flex-flow: column;
       flex-flow: column;
       height: 14.5625rem;
       padding: 1.125rem 1.25rem;
       position: relative
   }
   .event-group-item__info {
       -ms-flex: 1 1 auto;
       flex: 1 1 auto
   }
   .event-group-item__name {
       margin: 0 0 1.125rem
   }
   .event-group-item__price {
       -ms-flex: 1 1 auto;
       flex: 1 1 auto;
       font-family: visuelt-reg, "Helvetica Neue", Helvetica, Arial, sans-serif;
       font-size: .875rem;
       opacity: .75
   }
   .event-group-item__price-cta {
       -ms-flex-align: center;
       align-items: center;
       display: -ms-flexbox;
       display: flex;
       margin: 1.5rem 0 0
   }
   .event-group-meta-item:not(:last-child) {
       margin: 0 0 .625rem
   }
   .event-group-meta-item__icon {
       -ms-flex-align: center;
       align-items: center;
       display: -ms-flexbox;
       display: flex;
       height: 100%;
       -ms-flex-pack: center;
       justify-content: center;
       margin: 0 .5rem 0 0;
       max-width: 2.5rem
   }

-}
