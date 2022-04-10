module Calendar2
    exposing
        ( init
        , State
        , TimeSpan(..)
        , Msg
        , update
        , page
        , changeTimeSpan
        , view
        , viewConfig
        , ViewConfig
        , eventConfig
        , EventView
        , eventView
        , EventConfig
        , timeSlotConfig
        , TimeSlotConfig
        , subscriptions
        , getts
        )

{-|

Hey it's a calendar!

# Definition
@docs init, State, TimeSpan

# Update
@docs Msg, update, page, changeTimeSpan, eventConfig, EventConfig, timeSlotConfig, TimeSlotConfig, subscriptions

# View
@docs view, viewConfig, ViewConfig, EventView, eventView
-}

import Html exposing (..)
import Date exposing (Date)
import Config
import Calendar2.Internal as Internal
import Calendar2.Msg
import Calendar2.Msg as InternalMsg
-- import Time exposing (Time)
import Time 
-- import Mouse
import Html.Events.Extra.Mouse as Mouse





{-| Create the calendar
-}
init : TimeSpan -> Time.Posix -> State
init timeSpan viewing =
    State <| Internal.init (toInternalTimespan timeSpan) viewing

getts : State -> TimeSpan
getts state =
        case state of
                State state_ ->
                    fromInternalTimespan state_.timeSpan
        

{-| I won't tell you what's in here
-}
type State
    = State Internal.State


{-| All the time spans
-}
type TimeSpan
    = Month
    | Week
    | Day
    | Agenda


{-| Somehow update plz
-}
type Msg
    = Internal Calendar2.Msg.Msg


{-| oh yes, please solve my UI update problems
-}
update : EventConfig msg -> TimeSlotConfig msg -> Msg -> State -> ( State, Maybe msg )
update (EventConfig eventConfig_) (TimeSlotConfig timeSlotConfig_) (Internal msg) (State state) =
    let
        ( updatedCalendar, calendarMsg ) =
            Internal.update eventConfig_ timeSlotConfig_ msg state
    in
        ( State updatedCalendar, calendarMsg )


{-| Page by some interval based on the current view: Month, Week, Day
-}
page : Int -> State -> State
page step (State state) =
    State <| Internal.page step state


{-| Change between views like Month, Week, Day, etc.
-}
changeTimeSpan : TimeSpan -> State -> State
changeTimeSpan timeSpan (State state) =
    State <| Internal.changeTimeSpan (toInternalTimespan timeSpan) state


{-| Show me the money
-}
view : ViewConfig event -> List event -> State -> Html Msg
view (ViewConfig config) events (State state) =
    Html.map Internal (Internal.view config events state)


{-| configure view definition
-}
type ViewConfig event
    = ViewConfig (Config.ViewConfig event)


{-| configure time slot interactions
-}
type TimeSlotConfig msg
    = TimeSlotConfig (Config.TimeSlotConfig msg)


{-| configure event interactions
-}
type EventConfig msg
    = EventConfig (Config.EventConfig msg)


{-| event view type
-}
type EventView
    = EventView Config.EventView


{-| configure a custom event view
-}
eventView :
    { nodeName : String
    , classes : List ( String, Bool )
    , children : List (Html InternalMsg.Msg)
    }
    -> EventView
eventView { nodeName, classes, children } =
    EventView
        { nodeName = nodeName
        , classes = classes
        , children = children
        }


{-| configure the view
-}
viewConfig :
    { toId : event -> String
    , title : event -> String
    , start : event -> Time.Posix
    , end : event -> Time.Posix
    , event : event -> Bool -> EventView
    }
    -> ViewConfig event
viewConfig { toId, title, start, end, event } =
    let
        extractEventView eventView_ =
            case eventView_ of
                EventView eventView3 ->
                    eventView3

        eventView2 id selected =
            extractEventView <| event id selected
    in
        ViewConfig
            { toId = toId
            , title = title
            , start = start
            , end = end
            , event = eventView2
            }


{-| configure time slot interactions
-}
timeSlotConfig :
    { onClick : Time.Posix -> Mouse.Event -> Maybe msg
    , onMouseEnter : Time.Posix -> Mouse.Event -> Maybe msg
    , onMouseLeave : Time.Posix -> Mouse.Event -> Maybe msg
    , onDragStart : Time.Posix -> Mouse.Event -> Maybe msg
    , onDragging : Time.Posix -> Mouse.Event -> Maybe msg
    , onDragEnd : Time.Posix -> Mouse.Event -> Maybe msg
    --, onDragEnd : String -> Time.Posix ->  Maybe msg
    }
    -> TimeSlotConfig msg
timeSlotConfig { onClick, onMouseEnter, onMouseLeave, onDragStart, onDragging, onDragEnd } =
    TimeSlotConfig
        { onClick = onClick
        , onMouseEnter = onMouseEnter
        , onMouseLeave = onMouseLeave
        , onDragStart = onDragStart
        , onDragging = onDragging
        , onDragEnd = onDragEnd
        }


{-| configure event interactions
-}
eventConfig :
    { onClick : String -> Maybe msg
    , onMouseEnter : String -> Maybe msg
    , onMouseLeave : String -> Maybe msg
    , onDragStart : String -> Maybe msg
    , onDragging : String -> Int -> Maybe msg
    , onDragEnd : String -> Int -> Maybe msg
    , onEventMove : String -> Time.Posix -> Maybe msg --GUSA
    }
    -> EventConfig msg
eventConfig { onClick, onMouseEnter, onMouseLeave, onDragStart, onDragging, onDragEnd, onEventMove } =   --GUSA
    EventConfig
        { onClick = onClick
        , onMouseEnter = onMouseEnter
        , onMouseLeave = onMouseLeave
        , onDragStart = onDragStart
        , onDragging = onDragging
        , onDragEnd = onDragEnd
        , onEventMove = onEventMove --GUSA
        }


{-| drag event subscriptions
-}
subscriptions : State -> Sub Msg
-- -- subscriptions : State -> Sub (Mouse.Event -> InternalMsg.Msg)
subscriptions (State state) =
--     Sub.map Internal (Internal.subscriptions state)
       Sub.none


toInternalTimespan : TimeSpan -> InternalMsg.TimeSpan
toInternalTimespan timeSpan =
    case timeSpan of
        Month ->
            InternalMsg.Month

        Week ->
            InternalMsg.Week

        Day ->
            InternalMsg.Day

        Agenda ->
            InternalMsg.Agenda

fromInternalTimespan :  InternalMsg.TimeSpan ->TimeSpan
fromInternalTimespan timeSpan =
    case timeSpan of
            InternalMsg.Month ->
                    Month

            InternalMsg.Week ->
                    Week

            InternalMsg.Day ->
                    Day

            InternalMsg.Agenda ->
                    Agenda

