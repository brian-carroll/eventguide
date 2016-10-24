module Tests exposing (all)

import Test exposing (Test, describe, test)
import Expect exposing (true)
import Api.TicketMaster as TicketMaster
import Json.Decode

import Data.EventExample as EventExample
import Data.TicketMasterResponse as TicketMasterResponse


all : Test
all =
    describe "eventguide"
        [ decodeTicketMasterResponse
        ]


decodeTicketMasterResponse : Test
decodeTicketMasterResponse =
    let
        noErrors decoder data =
            case Json.Decode.decodeString decoder data of
                Ok _ ->
                    True
                Err _ ->
                    False
    in
        describe "TicketMaster JSON decoder"
            [ test "can decode a single event"
                (\_ -> Expect.true "Decoder error" (noErrors TicketMaster.eventDecoder EventExample.json))
            , test "can decode multiple events"
                (\_ -> Expect.true "Decoder error" (noErrors TicketMaster.responseDecoder TicketMasterResponse.json))
            ]
