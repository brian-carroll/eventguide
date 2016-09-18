module Tests exposing (all)

import Test exposing (Test, describe, test)
import Expect exposing (true)
import EventExample
import TicketMaster
import Json.Decode

all : Test
all =
    describe "eventguide"
        [ decodeTicketMasterEvent
        ]

decodeTicketMasterEvent : Test
decodeTicketMasterEvent =
    let
        decodeResult =
            Json.Decode.decodeString TicketMaster.eventDecoder EventExample.json

        decodesWithoutErrors =
            case decodeResult of
                Ok _ ->
                    True
                Err _ ->
                    False
    in
    describe "TicketMaster JSON decoder"
        [ test "can decode an event" (\_ -> Expect.true "Decoder error" decodesWithoutErrors)
        ]