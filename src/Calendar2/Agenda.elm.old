module Calendar2.Agenda exposing (..)

-- import Date exposing (Date)
-- import Date.Extra
import Date
import Time
import Time.Extra
import Html exposing (..)
import Html.Attributes exposing (..)
import Helpers
import Config exposing (ViewConfig)


type alias EventGroup event =
     { date : Date.Date
    -- { date : Time.Posix
    , events : List event
    }


eventsGroupedByDate : ViewConfig event -> List event -> List (EventGroup event)
eventsGroupedByDate config events =
    let
        initEventGroup event =
            { date =
                Date.fromPosix Time.utc (config.start event)
                    |> Date.floor Date.Day
            , events = [ event ]
            }

        buildEventGroups event eventGroups =
            let
                eventStart =
                    Date.fromPosix Time.utc (config.start event)

                isEventPartOfGroup eventGroup =
                    eventStart
                        |> Date.isBetween eventGroup.date (Date.add Date.Days 1 eventGroup.date)
            in
                case eventGroups of
                    [] ->
                        [ initEventGroup event ]

                    eventGroup :: restOfEventGroups ->
                        if isEventPartOfGroup eventGroup then
                            { eventGroup | events = event :: eventGroup.events } :: restOfEventGroups
                        else
                            initEventGroup event :: eventGroups

    in
        -- List.sortBy (Date.toTime << config.start) events
        -- List.sortBy (Date.toRataDie << (\ -> Date.fromPosix Time.utc  config.start)) events
        List.sortBy (Time.posixToMillis << config.start ) events
            |> List.foldr buildEventGroups []


view : ViewConfig event -> List event -> Time.Posix -> Html msg
view config events posix =
    let
        groupedEvents =
            eventsGroupedByDate config events
            -- eventsGroupedByDate config (Date.fromPosix Time.utc (config events))

        date = Date.fromPosix Time.utc posix 

        isDateInMonth eventsDate =
            eventsDate
                -- |> Date.Extra.isBetween (Date.Extra.floor Date.Extra.Month date) (Date.Extra.ceiling Date.Extra.Month date)
                |> Date.isBetween (Date.floor Date.Month eventsDate) (Date.ceiling Date.Month eventsDate)


        filteredEventsByMonth =
             List.filter (isDateInMonth << .date) groupedEvents

        getAgendaRowView eventGroup =
            case eventGroup.events of
                [] ->
                    []

                firstEvent :: restOfEvents ->
                    viewAgendaRowWithDate config eventGroup firstEvent :: (List.map (viewAgendaRow config) restOfEvents)
    in
        table [ class "elm-calendar--agenda" ]
            [ viewAgendaHeader
            , tbody [ class "elm-calendar--agenda-tbody" ]
                (List.map getAgendaRowView filteredEventsByMonth
                    |> List.concat
                )
            ]


viewAgendaHeader : Html msg
viewAgendaHeader =
    thead [ class "elm-calendar--agenda-header" ]
        [ tr []
            [ th [ class "elm-calendar--header-cell" ] [ text "Date" ]
            , th [ class "elm-calendar--header-cell" ] [ text "Time" ]
            , th [ class "elm-calendar--header-cell" ] [ text "Event" ]
            ]
        ]


viewAgendaRowWithDate : ViewConfig event -> EventGroup event -> event -> Html msg
viewAgendaRowWithDate config eventGroup event =
    let
        dateString =
            -- Date.Extra.toFormattedString "EE MM d" eventGroup.date
            Date.format "EE MM d" eventGroup.date

        timeCell =
            td [ class "elm-calendar--agenda-date-cell", rowspan (List.length eventGroup.events) ] [ text <| dateString ]
    in
        tr [ class "elm-calendar--agenda-day" ]
            (timeCell :: viewTimeAndEvent config event)


viewAgendaRow : ViewConfig event -> event -> Html msg
viewAgendaRow config event =
    tr [ class "elm-calendar--agenda-day" ]
        (viewTimeAndEvent config event)


viewTimeAndEvent : ViewConfig event -> event -> List (Html msg)
viewTimeAndEvent config event =
    let
        startTime =
            Helpers.hourString <| config.start event

        endTime =
            Helpers.hourString <| config.end event

        timeRange =
            startTime ++ " - " ++ endTime
    in
        [ td [ class "elm-calendar--agenda-cell" ] [ text timeRange ]
        , td [ class "elm-calendar--agenda-cell" ] [ text <| config.title event ]
        ]
