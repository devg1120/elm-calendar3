module Calendar2.Month exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
-- import Date exposing (Date)
-- import Date.Extra
-- import Date.Extra.Facts
import Date
-- import Time exposing (Month(..))
-- import Time exposing (Weekday(..))
import Time
import Time.Extra

import Config exposing (ViewConfig)
import Helpers
import Calendar2.Msg exposing (Msg)
import Calendar2.Event as Event exposing (rangeDescription)
import String


view : ViewConfig event -> List event -> Maybe String -> Time.Posix -> Html Msg
view config events selectedId viewing =
    let
        weeks =
            Helpers.weekRangesFromMonth (Time.toYear Time.utc viewing) (Time.toMonth Time.utc viewing)
    in
        div [ class "elm-calendar--column" ]
            [ viewMonthHeader
            , div [ class "elm-calendar--month" ]
                (List.map (viewMonthRow config events selectedId) weeks)
            ]


-- GUSA
-- dayOfWeekFromWeekdayNumber : Int -> Day
dayOfWeekFromWeekdayNumber : Int -> Date.Weekday
dayOfWeekFromWeekdayNumber n =
  case n of
    1 -> Time.Mon
    2 -> Time.Tue
    3 -> Time.Wed
    4 -> Time.Thu
    5 -> Time.Fri
    6 -> Time.Sat
    _ -> Time.Sun

viewMonthHeader : Html Msg
viewMonthHeader =
    let
        viewDayOfWeek int =
            -- viewDay <| Date.Extra.Facts.dayOfWeekFromWeekdayNumber int
            viewDay <| dayOfWeekFromWeekdayNumber int
    in
        div [ class "elm-calendar--row" ] (List.map viewDayOfWeek (List.range 0 6))


-- viewDay : Date.Date -> Html Msg
-- viewDay date =
--     div [ class "elm-calendar--month-day-header" ]
--         [ a [ class "elm-calendar--date", href "#" ] [ text <| Date.format "E" date ] ]
-- 

toJapaneseWeekday : Date.Weekday -> String
toJapaneseWeekday weekday =
  case weekday of
    Time.Mon -> "月"
    Time.Tue -> "火"
    Time.Wed -> "水"
    Time.Thu -> "木"
    Time.Fri -> "金"
    Time.Sat -> "土"
    Time.Sun -> "日"

viewDay : Time.Weekday -> Html Msg
viewDay weekday =
    div [ class "elm-calendar--month-day-header" ]
        [ a [ class "elm-calendar--date", href "#" ] [ text <| toJapaneseWeekday weekday ] ]

viewMonthRow : ViewConfig event -> List event -> Maybe String -> List Time.Posix -> Html Msg
viewMonthRow config events selectedId week =
    div [ class "elm-calendar--month-row" ]
        [ viewMonthRowBackground week
        , viewMonthRowContent config events selectedId week
        ]


viewMonthRowBackground : List Time.Posix -> Html Msg
viewMonthRowBackground week =
    div [ class "elm-calendar--month-row-background" ]
        (List.map (\_ -> div [ class "elm-calendar--cell" ] []) week)


viewMonthRowContent : ViewConfig event -> List event -> Maybe String -> List Time.Posix -> Html Msg
viewMonthRowContent config events selectedId week =
    let
        dateCell posix =
            div [ class "elm-calendar--date-cell" ]
                [ Date.fromPosix Time.utc posix
                    |> Date.day
                    |> String.fromInt
                    |> text
                ]

        datesRow =
            div [ class "elm-calendar--row" ] (List.map dateCell week)

        eventRows =
            List.filterMap (viewWeekEvent config week selectedId) events
                |> List.take 3
    in
        div [ class "elm-calendar--month-week" ]
            (datesRow :: eventRows)


-- viewWeekEvent : ViewConfig event -> List Date -> Maybe String -> event -> Maybe (Html Msg)
viewWeekEvent : ViewConfig event -> List Time.Posix -> Maybe String -> event -> Maybe (Html Msg)
viewWeekEvent config week selectedId event =
    let
        eventStart =
           -- Date.fromPosix Time.utc (config.start event)
           config.start event
        eventEnd =
           -- Date.fromPosix Time.utc (config.end event)
           config.end event
        eventRange sunday =
            -- rangeDescription eventStart eventEnd Date.Sunday sunday
            rangeDescription eventStart eventEnd Time.Extra.Sunday sunday
    in
        Maybe.map eventRange (List.head week)
            |> Maybe.andThen (Event.maybeViewMonthEvent config event selectedId)
