module Main exposing (main)

{-| Event guide with imported content on listed events
@docs main
-}

-- External modules

import Html
import Task
import Http
import Platform.Cmd exposing (Cmd)
import Date
import Time
import Dict exposing (Dict)


-- Local modules

import Api.TicketMaster as TicketMaster
import Api.YouTube as YouTube
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
