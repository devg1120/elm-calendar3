module Config exposing (..)

-- import Date exposing (Date)
-- import Time exposing (Time)
import Time 
-- import Mouse
import Html.Events.Extra.Mouse as Mouse

import Html exposing (Html, Attribute)
import Calendar2.Msg as InternalMsg


type alias EventView =
    { nodeName : String
    , classes : List ( String, Bool )
    , children : List (Html InternalMsg.Msg)
    }


type alias ViewConfig event =
    { toId : event -> String
    , title : event -> String
    , start : event -> Time.Posix
    , end : event -> Time.Posix
    , event : event -> Bool -> EventView
    }


type alias TimeSlotConfig msg =
    { onClick : Time.Posix -> Mouse.Event -> Maybe msg
    , onMouseEnter : Time.Posix -> Mouse.Event -> Maybe msg
    , onMouseLeave : Time.Posix -> Mouse.Event -> Maybe msg
    , onDragStart : Time.Posix -> Mouse.Event -> Maybe msg
    , onDragging : Time.Posix -> Mouse.Event -> Maybe msg
    , onDragEnd : Time.Posix -> Mouse.Event -> Maybe msg
    --, onDragEnd : String -> Time.Posix ->  Maybe msg
    }
    
    {--
type alias TimeSlotConfig msg =
    { onClick : Time.Posix -> ( Float, Float ) -> Maybe msg
    , onDragEnd : Time.Posix -> ( Float, Float ) -> Maybe msg
    , onDragStart : Time.Posix -> ( Float, Float ) -> Maybe msg
    , onDragging : Time.Posix -> ( Float, Float ) -> Maybe msg
    --, onMouseEnter : Time.Posix -> Html.Events.Extra.Mouse.Event -> Maybe msg
    --, onMouseLeave : Time.Posix -> Html.Events.Extra.Mouse.Event -> Maybe msg
    , onMouseEnter : Time.Posix -> Mouse.Event -> Maybe msg
    , onMouseLeave : Time.Posix -> Mouse.Event -> Maybe msg
    }
    --}

type alias EventConfig msg =
    { onClick : String -> Maybe msg
    , onMouseEnter : String -> Maybe msg
    , onMouseLeave : String -> Maybe msg
    , onDragStart : String -> Maybe msg
    -- , onDragging : String -> Time.Posix -> Maybe msg
    , onDragging : String -> Int -> Maybe msg
    -- , onDragEnd : String -> Time.Posix -> Maybe msg
    , onDragEnd : String -> Int -> Maybe msg
    , onEventMove : String -> Time.Posix -> Maybe msg --GUSA
    }
