module View exposing (root)

-- External modules
import Html exposing (Html, div, text)
import Http

-- Local modules
import Types exposing (..)



root : Model -> Html Msg
root model =
    div []
        [ text (toString model)
        ]
