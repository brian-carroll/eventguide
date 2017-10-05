module View.Modal exposing (modal)

-- Libraries

import Html exposing (..)
import Html.Attributes exposing (style, attribute, width, height, src, property)
import Html.Events exposing (onClick)
import Html.CssHelpers
import Json.Encode exposing (string)


-- Local modules

import Types exposing (..)
import Styles.Selectors exposing (..)


{ id, class, classList } =
    Html.CssHelpers.withNamespace ""


modal : Model -> Html Msg
modal model =
    case model.modalVideo of
        Nothing ->
            div [] []

        Just video ->
            div [ class [ ModalWrapper ] ]
                [ div
                    [ class [ Modal ] ]
                    [ iframe
                        [ src video.url
                        , width 600
                        , height 400
                        , attribute "frameborder" "0"
                        , attribute "allowfullscreen" ""
                        ]
                        []
                    ]
                , div [ class [ ModalFill ] ]
                    [ a
                        [ class [ ModalClose ]
                        , property "innerHTML" <| string "&times;"
                        , onClick CloseModal
                        ]
                        []
                    ]
                ]



{-

   <div class="modal__wrapper" id="mg-intro-video">
     <div class="modal__fill js-hide-modal"></div>

     <div class="modal modal--video">
       <a class="modal__close js-hide-modal">&times;</a>

       <div class="modal__body">
         <div class="video-embed__wrapper">
           <a class="oembed" href="https://vimeo.com/129215775"></a>
         </div>
       </div>
     </div>
   </div>

-}
