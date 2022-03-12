module Calendar2.Week exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
-- import Date exposing (Date)
import Date
import Time
import Time.Extra
--import Calendar2.Day exposing (viewTimeGutter, viewTimeGutterHeader, viewDate, viewDaySlotGroup, viewAllDayCell, viewDayEvents)
import Calendar2.Day exposing (viewTimeGutter, viewTimeGutterHeader, viewDate, viewDaySlotGroup, viewDayEvents)
import Calendar2.Month exposing (viewWeekEvent)
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
    let _ = Debug.log "OK" in
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
        --v2 = Time.Extra.add Time.Extra.Sunday 1 Time.utc viewing
        weekRange =
            Helpers.dayRangeOfWeek viewing
            --Helpers.dayRangeOfWeek v2
    in
        div [ class "elm-calendar--week" ]
            --[ viewWeekHeader weekRange
            [ viewWeekHeader config events selectedId weekRange
            , viewWeekContent config events selectedId viewing weekRange
            ]

--viewAllDayCell2 : List Time.Posix -> Html Msg
viewAllDayCell2 : ViewConfig event -> List event -> Maybe String -> List Time.Posix -> Html Msg
viewAllDayCell2 config events selectedId days =
    let
        viewAllDayText =
            div [ class "elm-calendar--all-day-text" ] [ text "2Allday" ]

        eventRows =
            --List.filterMap (viewWeekEvent config week selectedId) events
            List.filterMap (viewWeekEvent config days selectedId) events
                |> List.take 11 --GUSA 7  week-row  縦数

        viewAllDay day =
            div [ class "elm-calendar--all-day" ]
                []
    in
        div [ class "elm-calendar--all-day-cell" ]
            --(viewAllDayText :: List.map viewAllDay days)
            (viewAllDayText :: eventRows)

--viewWeekHeader : List Time.Posix -> Html Msg
viewWeekHeader :  ViewConfig event -> List event -> Maybe String -> List Time.Posix -> Html Msg
viewWeekHeader config events selectedId days =
    let
       viewAllDayText =
            div [ class "elm-calendar--all-day-text" ] [ text "2Allday" ]
       eventRows =
            --List.filterMap (viewWeekEvent config week selectedId) events
            List.filterMap (viewWeekEvent config days selectedId) events
                |> List.take 11 --GUSA 7  week-row  縦数
    in
    div [ class "elm-calendar--week-header" ]
        ( viewDates days :: viewAllDayText :: (viewTimeGutterHeader :: eventRows ))

        {--
--viewWeekHeader : List Time.Posix -> Html Msg
viewWeekHeader :  ViewConfig event -> List event -> Maybe String -> List Time.Posix -> Html Msg
viewWeekHeader config events selectedId days =
    div [ class "elm-calendar--week-header" ]
        [ viewDates days
        --, viewAllDayCell2 days
        , viewAllDayCell2 config events selectedId days
        ]
        --}

viewDates : List Time.Posix -> Html Msg
viewDates days =
    div [ class "elm-calendar--dates" ]
        (viewTimeGutterHeader :: List.map viewDate days)
