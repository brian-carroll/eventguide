module View exposing (root)

-- External modules

import Html exposing (..)
import Html.Attributes exposing (..)


-- import Html.Events exposing (..)
-- Local modules

import Types exposing (..)


inputForm : Model -> Html Msg
inputForm model =
    div []
        [ input
            [ placeholder "Start Date"
            , value (TicketMaster.dateFormat model.startDate)
            , onInput ChangeStartDate
            ]
            []
        , input
            [ placeholder "End Date"
            , value (TicketMaster.dateFormat model.endDate)
            , onInput ChangeEndDate
            ]
            []
        ]
