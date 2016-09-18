module State exposing (init,update,subscriptions)

import Types exposing (..)


init : ( Model, Cmd Msg )
init = ...


update : Msg -> Model -> ( Model, Cmd Msg )
update action model = ...


subscriptions : Model -> Sub Msg
subscriptions model =
  Websocket.listen "ws://echo.websocket.org" Echo
