module Tests exposing (all)

import Test exposing (Test, describe, test)
import Expect
import Api.TicketMaster as TicketMaster
import Api.YouTube as YouTube
import Json.Decode

import Data.EventExample as EventExample
import Data.TicketMasterResponse as TicketMasterResponse
import Data.YouTubeResponse as YouTubeResponse


all : Test
all =
    describe "eventguide"
        [ decodeTicketMaster
        , decodeYouTube
        ]


expectNoDecodeErrors : Json.Decode.Decoder a -> String -> Expect.Expectation
expectNoDecodeErrors decoder data =
    case Json.Decode.decodeString decoder data of
        Ok _ ->
            Expect.pass
        Err e ->
            Expect.fail e


decodeTicketMaster : Test
decodeTicketMaster =
    describe "TicketMaster JSON decoder"
        [ test "can decode a single event"
            (\_ -> expectNoDecodeErrors TicketMaster.eventDecoder EventExample.json)
        , test "can decode multiple events"
            (\_ -> expectNoDecodeErrors TicketMaster.responseDecoder TicketMasterResponse.json)
        ]


decodeYouTube : Test
decodeYouTube =
    describe "YouTube JSON decoder"
        [ test "can decode an example response"
            (\_ -> expectNoDecodeErrors YouTube.decodeSearch YouTubeResponse.json)
        ]
