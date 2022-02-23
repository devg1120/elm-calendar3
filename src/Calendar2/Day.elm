module Calendar2.Day exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Date exposing (Date)
-- import Date.Extra
import Date
import Time
import Time.Extra
import Config exposing (ViewConfig)
import Json.Decode as Json
import Helpers
import Calendar2.Msg exposing (Msg(..))
--import Mouse
-- import Html.Events.Extra.Mouse as Mouse 
import Html.Events.Extra.Mouse 
import Calendar2.Event as Event exposing (rangeDescription)
import Html5.DragDrop as DragDrop


view : ViewConfig event -> List event -> Maybe String -> Time.Posix -> Html Msg
view config events selectedId day =
    div [ class "elm-calendar--day" ]
        [ viewDayHeader day
        , div [ class "elm-calendar--day-content" ]
            [ viewTimeGutter day
            , viewDaySlot config events selectedId day
            ]
        ]


viewDate : Time.Posix -> Html Msg
viewDate posix =
    let
        title_day =
            Date.format "EE M/d" (Date.fromPosix Time.utc posix)
    in
        div [ class "elm-calendar--date-header" ]
            [ a [ class "elm-calendar--date", href "#" ] [ text <| title_day ] ]


viewDayHeader : Time.Posix -> Html Msg
viewDayHeader day =
    div [ class "elm-calendar--day-header" ]
        [ viewTimeGutterHeader
        , viewDate day
        ]


viewTimeGutter : Time.Posix -> Html Msg
viewTimeGutter date =
    Helpers.hours date
        |> List.map viewTimeSlotGroup
        |> div [ class "elm-calendar--time-gutter" ]


viewTimeGutterHeader : Html Msg
viewTimeGutterHeader =
    div [ class "elm-calendar--time-gutter-header" ] []


viewTimeSlotGroup : Time.Posix -> Html Msg
viewTimeSlotGroup date =
    div [ class "elm-calendar--time-slot-group" ]
        [ viewHourSlot date
        , div [ class "elm-calendar--time-slot" ] []
        ]


viewHourSlot : Time.Posix -> Html Msg
viewHourSlot date =
    div [ class "elm-calendar--hour-slot" ]
        [ span [ class "elm-calendar--time-slot-text" ] [ text <| Helpers.hourString date ] ]


-- GUSA
flip : (a -> b -> c) -> b -> a -> c
flip function argB argA =
    function argA argB

viewDaySlot : ViewConfig event -> List event -> Maybe String -> Time.Posix -> Html Msg
viewDaySlot config events selectedId day =
    Helpers.hours day
        |> List.map viewDaySlotGroup
        |> (flip (++)) (viewDayEvents config events selectedId day)
        |> div [ class "elm-calendar--day-slot" ]


viewDaySlotGroup : Time.Posix -> Html Msg
viewDaySlotGroup date =
    div [ class "elm-calendar--time-slot-group" ]
        [ viewTimeSlot date
        , viewTimeSlot date
        ]


-- viewTimeSlot : Date -> Html Msg
-- viewTimeSlot date =
--     div
--         [ class "elm-calendar--time-slot"
--         , on "click" (Json.map (TimeSlotClick date)  Html.Events.Extra.Mouse.Event)
--         , on "mouseenter" (Json.map (TimeSlotMouseEnter date)  Html.Events.Extra.Mouse.Event)
--         , on "mouseleave" (Json.map (TimeSlotMouseLeave date)  Html.Events.Extra.Mouse.Event)
--         , on "mousedown" (Json.map (TimeSlotDragStart date)  Html.Events.Extra.Mouse.Event.clientPos)
--         ]
--         []

divStyle =
    [ 
    ]

viewTimeSlot : Time.Posix -> Html Msg
viewTimeSlot date =
    --let
    --     p =  { width = 100
    --          , height = 100
    --          , x = 9
    --          , y = 9
    --          }
    --in
    div (
        [ class "elm-calendar--time-slot"
        , Html.Events.Extra.Mouse.onClick (\event -> TimeSlotClick date event)
        , Html.Events.Extra.Mouse.onEnter (\event -> TimeSlotMouseEnter date event)
        , Html.Events.Extra.Mouse.onLeave (\event -> TimeSlotMouseLeave date event)
        , Html.Events.Extra.Mouse.onDown (\event -> TimeSlotDragStart date event)


        ]
          --++ DragDrop.droppable DragDropMsg p
          --++ DragDrop.droppable DragDropMsg "AA"
          ++ DragDrop.droppable DragDropMsg date
          )
        []
        


viewDayEvents : ViewConfig event -> List event -> Maybe String -> Time.Posix -> List (Html Msg)
viewDayEvents config events selectedId day =
    List.filterMap (viewDayEvent config day selectedId) events


viewDayEvent : ViewConfig event -> Time.Posix -> Maybe String -> event -> Maybe (Html Msg)
viewDayEvent config day selectedId event =
    let
        eventStart =
              -- Date.fromPosix Time.utc (config.start event)
              config.start event
        eventEnd =
              -- Date.fromPosix Time.utc (config.end event)
              config.end event
        eventRange  =
            rangeDescription eventStart eventEnd Time.Extra.Day day
    in
        Event.maybeViewDayEvent config event selectedId eventRange


viewAllDayCell : List Time.Posix -> Html Msg
viewAllDayCell days =
    let
        viewAllDayText =
            div [ class "elm-calendar--all-day-text" ] [ text "All day" ]

        viewAllDay day =
            div [ class "elm-calendar--all-day" ]
                []
    in
        div [ class "elm-calendar--all-day-cell" ]
            (viewAllDayText :: List.map viewAllDay days)
