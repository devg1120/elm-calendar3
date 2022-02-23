module Calendar2.Week exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
-- import Date exposing (Date)
import Date
import Time

import Calendar2.Day exposing (viewTimeGutter, viewTimeGutterHeader, viewDate, viewDaySlotGroup, viewAllDayCell, viewDayEvents)
import Calendar2.Msg exposing (Msg)
import Config exposing (ViewConfig)
import Helpers


viewWeekContent :
    ViewConfig event
    -> List event
    -> Maybe String
    -> Time.Posix
    -> List Time.Posix
    -> Html Msg
viewWeekContent config events selectedId viewing days =
    let
        timeGutter =
            viewTimeGutter viewing

        weekDays =
            List.map (viewWeekDay config events selectedId) days
    in
        div [ class "elm-calendar--week-content" ]
            (timeGutter :: weekDays)


viewWeekDay : ViewConfig event -> List event -> Maybe String -> Time.Posix -> Html Msg
viewWeekDay config events selectedId posix =
    let
        viewDaySlots =
            Helpers.hours posix
                |> List.map viewDaySlotGroup

        dayEvents =
            viewDayEvents config events selectedId posix
    in
        div [ class "elm-calendar--day" ]
            (viewDaySlots ++ dayEvents)


view : ViewConfig event -> List event -> Maybe String -> Time.Posix -> Html Msg
view config events selectedId viewing =
    let
        weekRange =
            Helpers.dayRangeOfWeek viewing
    in
        div [ class "elm-calendar--week" ]
            [ viewWeekHeader weekRange
            , viewWeekContent config events selectedId viewing weekRange
            ]


viewWeekHeader : List Time.Posix -> Html Msg
viewWeekHeader days =
    div [ class "elm-calendar--week-header" ]
        [ viewDates days
        , viewAllDayCell days
        ]


viewDates : List Time.Posix -> Html Msg
viewDates days =
    div [ class "elm-calendar--dates" ]
        (viewTimeGutterHeader :: List.map viewDate days)
