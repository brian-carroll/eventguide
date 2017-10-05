module Styles.Modal exposing (css)

import Css exposing (..)
import Styles.Constants exposing (..)
import Styles.Selectors exposing (..)


css : Stylesheet
css =
    stylesheet
        [ class ModalWrapper
            [ property "display" "flex"
            , alignItems center
            , justifyContent center
            , position fixed
            , top zero
            , right zero
            , bottom zero
            , left zero
            , zIndex (int 75)
            ]
        , class ModalFill
            [ position fixed
            , width (pct 100)
            , height (pct 100)
            , backgroundColor <| asphaltM
            , opacity (num 0.5)
            , property "transition" <| "all 0.3s 0.4s" ++ cubic
            ]
        , class Iframe
            [ minWidth (pc 100)
            ]
        , class Modal
            [ width (px 600)
            , property "maxHeight" "calc(100vh - 50px)"
            , overflowY auto
            , backgroundColor greyXl
            , boxShadow5 (px 0) (px 1) (px 2) (px 0) (rgba 0 0 0 0.12)
            , borderRadius (px 2)
            , property "transition" <| "all 0.6s" ++ cubic
            , zIndex (int 10)
            ]
        , mediaQuery "only screen and (minWidth (px 460))"
            [ class Modal
                [ minWidth (px 320)
                , width (pct 80)
                ]
            ]
        , mediaQuery "only screen and (minWidth (px 860))"
            [ class Modal
                [ width (pct 60)
                ]
            ]
        , class ModalClose
            [ position absolute
            , top zero
            , right zero
            , zIndex (int 1)
            , padding2 (px 12) (px 24)
            , fontSize (px 24)
            , lineHeight (px 24)
            , color asphaltL
            , backgroundColor white
            , property "transition" <| "all 0.3s 0.4s" ++ cubic
            , hover
                [ color white
                , backgroundColor brandPrimary
                ]
            ]
        ]



-- type Class
--     = Modal__fill
--     | Modal__wrapper
--     | Modal
--     | Modal_FullScreen
--     | Modal_Video
--     | Modal__fill
--     | Modal
--     | Modal_Video
--     | Modal_FullScreen
--     | Modal__header
--     | Modal__body
--     | Modal__footer
--     | VideoEmbed__wrapper
--     | Modal_Login
--     | Btn_Block
--     | Modal_EmailList
--     | Modal__header
--     | Modal__body
--     | Modal__footer
--     | Modal__header
--     | Table__cell
--     | Table
--     | Table__cell
--     | Modal__close
{-



   , class Modal.modal_Video
   [  @media only screen and (maxWidth (px 600)) and (orientation landscape)
   [    top (px 50)
   , class Modal_FullScreen
   [  top (px 50)
   ,  right zero
   ,  bottom zero
   ,  left zero
   ,  width (pct 100)
   ,  maxWidth none
   ,  borderRadius zero
   ,  opacity zero
   ,  pointerEvents none
   ,  transition all 1.2s cubic
   ,  transform translateZ(0)
   , class Modal__header,
    , class Modal__body,
    , class Modal__footer
   [    padding zero
    , class VideoEmbed__wrapper
   [    width (pct 75)
   ,    margin zero auto
   ,    paddingBottom 40.(pct 25)
   ,    div.oembedallContainer
   [      position absolute
   ,      top (px 12)
   ,      right (px 100)
   ,      bottom (px 100)
   ,      left (px 100)
   , class Modal_Login
   [  width (px 320) !important
   ,  backgroundColor white
   , class Btn_Block
   [    marginTop (px 24)

   , class Modal_EmailList
   [  width (px 320) !important
   ]
   , class Modal__header,, class Modal__body,, class Modal__footer
   [  padding (px 16) (px 24)
   ]
   , class Modal__header
   [  position relative
   ,  overflow hidden
   ,  borderRadius (px 6) (px 6) zero 0
   ,  backgroundColor white
   ,  borderBottom (px 1) solid greyL
   -- ,  //boxShadow inset zero (px 4) zero brandPrimary
   , , class Table__cell
   [    whiteSpace nowrap
   ,    overflow hidden
   ,    textOverflow ellipsis
   ,  }
    , class Table
   [tableLayout fixed
   ]
     h4
   [    marginBottom zero
   ,    fontWeight 700
   ,    whiteSpace nowrap
   ,    overflow hidden
   ,    textOverflow ellipsis
   ,  }
     hgrouplastOfType
   [width (px 120)
   ]
     hgroupfirstOfType
   [width auto
   ]
    , class Table__cell+.table__cell
   [paddingLeft (px 24)
   ]
   -- //  &before
   -- [//    content ""
   -- ,//    position absolute
   -- ,//    top zero
   -- ,//    left zero
   -- ,//    display block
   -- ,//    width (pct 100)
   -- ,//    height (px 4)
   -- ,//    backgroundColor brandPrimary
   -- ,//  }
   -- }
-}
