module Calendar2.Month exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
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
--import Calendar2.Msg exposing (Msg)

--import Calendar2.Day exposing (viewTimeGutter, viewTimeGutterHeader, viewDate, viewDaySlotGroup, viewAllDayCell, viewDayEvents)

import Calendar2.Msg exposing (Msg(..))
import Calendar2.Event as Event exposing (rangeDescriptionFromMonth)
import Calendar2.Event as Event exposing (rangeDescriptionFromDay)
import String
import Html5.DragDrop as DragDrop

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
            viewDay <| dayOfWeekFromWeekdayNumber  int  
    in
        --div [ class "elm-calendar--row" ] (List.map viewDayOfWeek (List.range 0 6))
        div [ class "elm-calendar--row" ] (List.map viewDayOfWeek (List.range 0 6))


-- viewDay : Date.Date -> Html Msg
-- viewDay date =
--     div [ class "elm-calendar--month-day-header" ]
--         [ a [ class "elm-calendar--date", href "#" ] [ text <| Date.format "E" date ] ]
-- 

toJapaneseWeekday : Date.Weekday -> String
toJapaneseWeekday weekday =
  case weekday of
    Time.Mon -> "???"
    Time.Tue -> "???"
    Time.Wed -> "???"
    Time.Thu -> "???"
    Time.Fri -> "???"
    Time.Sat -> "???"
    Time.Sun -> "???"

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

        {--
viewMonthRowBackground : List Time.Posix -> Html Msg
viewMonthRowBackground week =
    div [ class "elm-calendar--month-row-background" ]
        (List.map (\_ -> div [ class "elm-calendar--cell" ] []) week)
        --}


viewMonthRowBackground : List Time.Posix -> Html Msg
viewMonthRowBackground week =
    div [ class "elm-calendar--month-row-background" ]
        (List.map (\ day -> 
                div ([ class "elm-calendar--cell" ] 
            ++ DragDrop.droppable DragDropMsg day
                )
                []) week)

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
            --rangeDescription eventStart eventEnd Time.Extra.Day day
            rangeDescriptionFromDay eventStart eventEnd Time.Extra.Day day
            --rangeDescriptionFromMonth eventStart eventEnd Time.Extra.Day day

    in
        --Event.maybeViewDayEvent config event selectedId eventRange
        maybeViewDayEvent config event selectedId eventRange
{--
maybeViewDayEvent : ViewConfig event -> event -> Maybe String -> Event.EventRange -> Maybe (Html Msg)
maybeViewDayEvent config event selectedId eventRange =
    case eventRange of
        Event.ExistsOutside ->
            Nothing

        _ ->
            Just <| eventSegment config event selectedId eventRange 
            --}

maybeViewDayEvent : ViewConfig event -> event -> Maybe String -> Event.EventRange -> Maybe (Html Msg)
maybeViewDayEvent config event selectedId eventRange =
    case eventRange of
        Event.StartsAndEnds ->
            Just <| eventSegment config event selectedId eventRange 

        _ ->
            Nothing

eventStyling :
    ViewConfig event
    -> event
    -> Event.EventRange
    -> List ( String, Bool )
    -> List (Html.Attribute msg)
eventStyling config event eventRange customClasses =
    let
        eventStart =
            config.start event
            -- Date.fromPosix Time.utc (config.start event)

        eventEnd =
            config.end event
            -- Date.fromPosix Time.utc (config.end event)

        classes =
            case eventRange of
                Event.StartsAndEnds ->
                    "elm-calendar--event elm-calendar--event-starts-and-ends"

                Event.ContinuesAfter ->
                    "elm-calendar--event elm-calendar--event-continues-after"

                Event.ContinuesPrior ->
                    "elm-calendar--event elm-calendar--event-continues-prior"

                Event.ContinuesAfterAndPrior ->
                    "elm-calendar--event"

                Event.ExistsOutside ->
                    ""

        styles = Event.styleDayEvent eventStart eventEnd
    in
        --[ classList (( classes, True ) :: customClasses)] ++   styles -- GUSA
        [ classList (( classes, True ) :: customClasses)] 

eventSegment : ViewConfig event -> event -> Maybe String -> Event.EventRange ->  Html Msg
eventSegment config event selectedId eventRange  =
    let
        eventId =
            config.toId event

        isSelected =
            Maybe.map ((==) eventId) selectedId
                |> Maybe.withDefault False

        { nodeName, classes, children } =
            config.event event isSelected
    in
        node nodeName
            ([ onClick <| EventClick eventId
             --, onMouseEnter <| EventMouseEnter eventId
             --, onMouseLeave <| EventMouseLeave eventId
             ]
             ++ DragDrop.draggable DragDropMsg eventId 
             ++ eventStyling config event eventRange classes
            )
            children



--viewDayEvent : ViewConfig event -> Time.Posix -> Maybe String -> event -> Maybe (Html Msg)
--viewDayEvent config day selectedId event =
--        Just (div [] [ text "O"])

viewMonthRowContent : ViewConfig event -> List event -> Maybe String -> List Time.Posix -> Html Msg
viewMonthRowContent config events selectedId week =
    let
        dateCell posix =
            div ([ class "elm-calendar--date-cell" ]
          --  ++ DragDrop.droppable DragDropMsg posix
                )
                [ Date.fromPosix Time.utc posix
                    |> Date.day
                    |> String.fromInt
                    |> text
                ]

                
        datesRow =
            div [ class "elm-calendar--row" ] (List.map dateCell week)
            

        eventRows =
            List.filterMap (viewWeekEvent config week selectedId) events
                |> List.take 11 --GUSA 7  week-row  ??????

        eventCell posix =
            div ([ class "elm-calendar--date-cell" ]
                )
                [ Date.fromPosix Time.utc posix
                    |> Date.day
                    |> (+) 100
                    |> String.fromInt
                    |> text
                ]

        eventDay =
            div [ class "elm-calendar--row" ] (List.map eventCell week)

        dayEvents posix =
                   viewDayEvents config events selectedId posix

        eventCell2 posix =
           let
             ev =  dayEvents posix
           in
           --div [ class "elm-calendar--date-cell" ]
           --[
           -- div [ ]
           --     
           --     [ Date.fromPosix Time.utc posix
           --         |> Date.day
           --         |> (+) 200
           --         |> String.fromInt
           --         |> text
           --     ]
           --     ,
           --  div [] [ text "@"]
           --  ]  
           div [ class "elm-calendar--date-cell" ] (dayEvents posix)

        eventDay2 =
            div [ class "elm-calendar--row" ] (List.map eventCell2 week)

------------------
{--
        dayEvents posix =
                   viewDayEvents config events selectedId posix
        eventDay3 =
            --div [ class "elm-calendar--row" ] (List.map dayEvents week)
            div [ class "elm-calendar--row" ] (List.concat (List.map dayEvents week))
            --}         
------------------
    in
        div [ class "elm-calendar--month-week" ]
            --(datesRow :: eventRows)
            --(datesRow :: eventRows ++ [datesRow])
            --(datesRow :: eventRows ++ [eventDay])
            --(datesRow :: eventRows ++ [eventDay] ++ [eventDay2] )
            (datesRow :: eventRows ++ [eventDay] ++ [eventDay2] )
            --(datesRow ::  [eventDay] ++ [eventDay2] ++ [eventDay3])


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

        --cmp = Date.compare eventStart eventEnd

        eventRange sunday =
            -- rangeDescription eventStart eventEnd Date.Sunday sunday
            --rangeDescription eventStart eventEnd Time.Extra.Sunday sunday
            rangeDescriptionFromMonth eventStart eventEnd Time.Extra.Sunday sunday

    in
        Maybe.map eventRange (List.head week)
            |> Maybe.andThen (Event.maybeViewMonthEvent config event selectedId)
