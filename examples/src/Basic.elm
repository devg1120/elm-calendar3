module Main exposing (..)

import Browser

import Html exposing (..)
import Calendar2
-- import Date exposing (Date)
import Time
import Fixtures
import Date




-- MAIN

main =
  Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL

type alias Model =
    { calendarState : Calendar2.State }


type alias Event =
    { id : String
    , title : String
    , start : Time.Posix
    , end : Time.Posix
    }


model : Model
model =
    { calendarState = Calendar2.init Calendar2.Month Fixtures.viewing }




init : () -> (Model, Cmd Msg)
init _ =
  ( model
  , Cmd.none
  )



-- UPDATE

type Msg
    = SetCalendarState Calendar2.Msg
    | SelectDate Time.Posix


-- update : Msg -> Model -> Model
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model_ =
    case msg of
        SetCalendarState calendarMsg ->
            let
                ( updatedCalendar, maybeMsg ) =
                    Calendar2.update eventConfig timeSlotConfig calendarMsg model.calendarState

                newModel =
                    { model_ | calendarState = updatedCalendar }
            in
                case maybeMsg of
                    Nothing ->
                      (
                        newModel
                        , Cmd.none
                      )

                    Just updateMsg ->
                        update updateMsg newModel

        SelectDate date ->
          (
            model_
            , Cmd.none
          )

-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model_ =
  Sub.none


-- VIEW


view : Model -> Html Msg
view model_ =
    div []
        [ Html.map SetCalendarState (Calendar2.view viewConfig Fixtures.events model_.calendarState) ]


viewConfig : Calendar2.ViewConfig Event
viewConfig =
    Calendar2.viewConfig
        { toId = .id
        , title = .title
        , start = .start
        , end = .end
        , event =
            \event isSelected ->
                Calendar2.eventView
                    { nodeName = "div"
                    , classes =
                        [ ( "elm-calendar--event-content", True )
                        , ( "elm-calendar--event-content--is-selected", isSelected )
                        ]
                    , children =
                        [ div []
                            [ text <| event.title ]
                        ]
                    }
        }


eventConfig : Calendar2.EventConfig Msg
eventConfig =
    Calendar2.eventConfig
        { onClick = \_ -> Nothing
        , onMouseEnter = \_ -> Nothing
        , onMouseLeave = \_ -> Nothing
        , onDragStart = \_ -> Nothing
        , onDragging = \_ _ -> Nothing
        , onDragEnd = \_ _ -> Nothing
        }


timeSlotConfig : Calendar2.TimeSlotConfig Msg
timeSlotConfig =
    Calendar2.timeSlotConfig
        -- { onClick = \date pos -> Just <| SelectDate date
        { onClick = \_ _ -> Nothing 
        , onMouseEnter = \_ _ -> Nothing
        , onMouseLeave = \_ _ -> Nothing
        , onDragStart = \_ _ -> Nothing
        , onDragging = \_ _ -> Nothing
        , onDragEnd = \_ _ -> Nothing
        }
