module View.Header exposing (siteHeader)

import Html exposing (..)
import Html.Attributes exposing (..)


siteHeader =
    div
        [ style [ ( "text-align", "center" ) ] ]
        [ h1 [] [ text "Brian's Event Guide" ] ]
