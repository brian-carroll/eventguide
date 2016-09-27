module View exposing (root)

-- External modules
import Html exposing (Html, div, text, img)
import Html.Attributes exposing (src, style)

-- Local modules
import Types exposing (..)



root : Model -> Html Msg
root model =
    div []
        [ img [ src "/assets/fb-profile-pic.jpg"
              , style [("height", "100px")]
              ]
              []
        , text (toString model)
        ]
