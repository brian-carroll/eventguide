module Main exposing (main)

{-| Event guide with imported content on listed events
@docs main
-}

-- External modules

import Html


-- Local modules

import Types exposing (..)
import View
import State exposing (init, update)


{-| Entry point for the app
-}
main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = (\_ -> Sub.none)
        , view = View.root
        }
