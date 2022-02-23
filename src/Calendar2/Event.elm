module Calendar2.Event exposing (..)

-- import Date exposing (Date)
-- import Date.Extra
import Date
import DateTime
import Time
import Time.Extra
import Html exposing (..)
import Html.Attributes exposing (class, classList, style)
import Html.Events exposing (..)
import Calendar2.Msg exposing (Msg(..), TimeSpan(..))
import Config exposing (ViewConfig)
import Json.Decode as Json
-- import Mouse
import Html.Events.Extra.Mouse as Mouse
import Html5.DragDrop as DragDrop

import Helpers
import List
import String

type EventRange
    = StartsAndEnds
    | ContinuesAfter
    | ContinuesPrior
    | ContinuesAfterAndPrior
    | ExistsOutside


isBetween : Time.Posix -> Time.Posix -> Time.Posix -> Bool
isBetween begin end target =
    let
       dt_begin = DateTime.fromPosix begin
       dt_end   = DateTime.fromPosix end
       dt_target   = DateTime.fromPosix target
    in
      if DateTime.compare dt_begin dt_target == LT then
           if DateTime.compare dt_target dt_end == LT then
             True
          else
             False
      else
       False

isBefore : Time.Posix -> Time.Posix -> Bool
isBefore begin  target =
    let
       dt_begin = DateTime.fromPosix begin
       dt_target   = DateTime.fromPosix target
    in
      if DateTime.compare dt_target dt_begin == LT then
             True
      else
       False

isAfter : Time.Posix -> Time.Posix -> Bool
isAfter end  target =
    let
       dt_end = DateTime.fromPosix end
       dt_target   = DateTime.fromPosix target
    in
      if DateTime.compare dt_end dt_target == LT then
             True
      else
       False

rangeDescription : Time.Posix -> Time.Posix -> Time.Extra.Interval -> Time.Posix -> EventRange
rangeDescription start end interval posix =
    -- let _  = Debug.log "rangeDescription:" posix in
    let 
        parts =  Time.Extra.posixToParts Time.utc posix 
        start_parts =  Time.Extra.posixToParts Time.utc  start
        end_parts =  Time.Extra.posixToParts Time.utc  end
        --_  = Debug.log "rangeDescription:" parts 
        --_  = Debug.log "           start:" start_parts 
        --_  = Debug.log "             end:" end_parts 
        in
    let

        begInterval =
            Time.Extra.floor interval Time.utc posix

        endInterval =
            -- Time.Extra.ceiling interval Time.utc posix
            Time.Extra.add interval 1 Time.utc posix

        -- b_parts =  Time.Extra.posixToParts Time.utc  begInterval
        -- e_parts =  Time.Extra.posixToParts Time.utc  endInterval
        -- _  = Debug.log "             begInterval:"  b_parts
        -- _  = Debug.log "             endInterval:"  e_parts

        --
        --
        --
        --
        -- dt_start = DateTime.fromPosix start
        -- dt_end   = DateTime.fromPosix end
        -- dt_begInterval   = DateTime.fromPosix begInterval
        -- dt_endInterval   = DateTime.fromPosix endInterval

        startsThisInterval   = isBetween begInterval endInterval start
        endsThisInterval     = isBetween begInterval endInterval end
        startsBeforeInterval = isBefore  begInterval start
        endsAfterInterval    = isAfter   endInterval end 
    in
        if startsThisInterval && endsThisInterval then
            StartsAndEnds
        else if startsBeforeInterval && endsAfterInterval then
            ContinuesAfterAndPrior
        else if startsThisInterval && endsAfterInterval then
            ContinuesAfter
        else if endsThisInterval && startsBeforeInterval then
            ContinuesPrior
        else
            ExistsOutside

eventStyling :
    ViewConfig event
    -> event
    -> EventRange
    -> TimeSpan
    -> List ( String, Bool )
    -> List (Html.Attribute msg)
eventStyling config event eventRange timeSpan customClasses =
    let
        eventStart =
            config.start event
            -- Date.fromPosix Time.utc (config.start event)

        eventEnd =
            config.end event
            -- Date.fromPosix Time.utc (config.end event)

        classes =
            case eventRange of
                StartsAndEnds ->
                    "elm-calendar--event elm-calendar--event-starts-and-ends"

                ContinuesAfter ->
                    "elm-calendar--event elm-calendar--event-continues-after"

                ContinuesPrior ->
                    "elm-calendar--event elm-calendar--event-continues-prior"

                ContinuesAfterAndPrior ->
                    "elm-calendar--event"

                ExistsOutside ->
                    ""

        styles =
            case timeSpan of
                Month ->
                     []

                Week ->
                     []

                Day ->
                    styleDayEvent eventStart eventEnd

                Agenda ->
                     []
    in
        -- [ classList (( classes, True ) :: customClasses),  styles ]
        [ classList (( classes, True ) :: customClasses)] ++   styles -- GUSA


maybeViewMonthEvent : ViewConfig event -> event -> Maybe String -> EventRange -> Maybe (Html Msg)
maybeViewMonthEvent config event selectedId eventRange =
    -- let _ = Debug.log "maybeViewMonthEvent:" eventRange in
    case eventRange of
        ExistsOutside ->
            Nothing

        _ ->
            Just <| viewMonthEvent config event selectedId eventRange


viewMonthEvent : ViewConfig event -> event -> Maybe String -> EventRange -> Html Msg
viewMonthEvent config event selectedId eventRange =
    let
        eventStart =
            Date.fromPosix Time.utc (config.start event)

        eventEnd =
            Date.fromPosix Time.utc (config.end event)

        numDaysThisWeek =
            case eventRange of
                StartsAndEnds ->
                    Date.diff Date.Days eventStart eventEnd + 1

                ContinuesAfter ->
                    7 - (Date.weekdayNumber eventStart) + 1

                ContinuesPrior ->
                    7 - (Date.weekdayNumber eventEnd) + 1

                ContinuesAfterAndPrior ->
                    7

                ExistsOutside ->
                    0

        eventWidthPercentage eventRange2 =
            (numDaysThisWeek
                |> toFloat
                |> (*) cellWidth
              --  |> toString
                |> String.fromFloat 
            )
                ++ "%"
    in
        if offsetLength eventStart > 0 then
            div [ class "elm-calendar--row" ]
                [ rowSegment (offsetPercentage eventStart) []
                , rowSegment (eventWidthPercentage eventRange) [ eventSegment config event selectedId eventRange Month ]
                ]
        else
            div [ class "elm-calendar--row" ]
                [ rowSegment (eventWidthPercentage eventRange) [ eventSegment config event selectedId eventRange Month ] ]



-- GUSA
-- (=>) : a -> b -> ( a, b )
-- (=>) =
--     (,)

--GUSA
{-|-}
msPerSecond : Int
msPerSecond =
  1000


{-|-}
msPerMinute : Int
msPerMinute =
  60 * msPerSecond


{-|-}
msPerHour : Int
msPerHour =
  60 * msPerMinute


{-|-}
msPerDay : Int
msPerDay =
  24 * msPerHour

msFromTimeParts : Int -> Int -> Int -> Int -> Int
msFromTimeParts hh mm ss ms =
  ms
  + msPerSecond * ss
  + msPerMinute * mm
  + msPerHour * hh

fractionalDay : Time.Posix -> Float
fractionalDay posix =
    let
        timeOfDayMS =
            msFromTimeParts (Time.toHour Time.utc posix) (Time.toMinute Time.utc posix) (Time.toSecond Time.utc posix) (Time.toMillis Time.utc posix)

    in
    toFloat timeOfDayMS / toFloat msPerDay


fractionalEndDay : Time.Posix -> Float
fractionalEndDay posix2 =     -- EVENT END 表示位置の補正
    let
        -- posix = Time.Extra.add Time.Extra.Millisecond -1 Time.utc posix2
        posix = Time.Extra.add Time.Extra.Minute -7 Time.utc posix2
        timeOfDayMS =
            msFromTimeParts (Time.toHour Time.utc posix) (Time.toMinute Time.utc posix) (Time.toSecond Time.utc posix) (Time.toMillis Time.utc posix)

    in
    toFloat timeOfDayMS / toFloat msPerDay

styleDayEvent : Time.Posix -> Time.Posix -> List (Html.Attribute msg)
-- styleDayEvent : Date.Date -> Date.Date -> Html.Attribute msg
styleDayEvent start end =
    let

        -- real-size   : 984px = 41 * 24 
        -- scroll-view : 600px
        -- ratio = 984 / 600 
        ratio =  1

{-
        startPercent =
            100 * (fractionalDay start) * ratio

        endPercent =
            100 * (fractionalEndDay end) * ratio 

        height =
            (String.fromFloat <| endPercent - startPercent) ++ "%"

        startPercentage =
            (String.fromFloat startPercent) ++ "%"
-}
        frame_hight_size = 41 * 24 
        startPercent =
             (fractionalDay start) * ratio

        endPercent =
             (fractionalEndDay end) * ratio 

        height =
            (String.fromFloat <| frame_hight_size * (endPercent - startPercent)) ++ "px"

        startPercentage =
            (String.fromFloat <| frame_hight_size * startPercent) ++ "px"
    in
                                                  -- style top/height  % => absulote
            [ style "top"   startPercentage
            , style "height"   height
            , style "left"   "0%"
            , style "width"   "90%"
            , style "position"   "absolute"
            ]

maybeViewDayEvent : ViewConfig event -> event -> Maybe String -> EventRange -> Maybe (Html Msg)
maybeViewDayEvent config event selectedId eventRange =
    case eventRange of
        ExistsOutside ->
            Nothing

        _ ->
            Just <| eventSegment config event selectedId eventRange Day


eventSegment : ViewConfig event -> event -> Maybe String -> EventRange -> TimeSpan -> Html Msg
eventSegment config event selectedId eventRange timeSpan =
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
             , onMouseEnter <| EventMouseEnter eventId
             , onMouseLeave <| EventMouseLeave eventId
             -- GUSA
             -- , on "mousedown" <| Json.map (EventDragStart eventId) Mouse.position
             --, DragDrop.droppable  <| Json.map (EventDragStart eventId) Mouse.position
             --,DragDrop.draggable DragDropMsg eventId
             ]
             ++ DragDrop.draggable DragDropMsg eventId 
                ++ eventStyling config event eventRange timeSpan classes
            )
            children


cellWidth : Float
cellWidth =
    100.0 / 7


offsetLength : Date.Date -> Float
offsetLength date =
    (Date.weekdayNumber date)
        |> toFloat
        |> (*) cellWidth


offsetPercentage : Date.Date -> String
offsetPercentage date =
    (offsetLength date
        -- |> Date.toIsoString
        |> String.fromFloat
    )
        ++ "%"


-- styleRowSegment : String -> Html.Attribute msg
styleRowSegment : String -> List (Html.Attribute msg)
styleRowSegment widthPercentage =
    -- style
    --     [ ( "flex-basis", widthPercentage )
    --     , ( "max-width", widthPercentage )
    --     ]
        [ style  "flex-basis"  widthPercentage 
        , style  "max-width"  widthPercentage 
        ]


rowSegment : String -> List (Html Msg) -> Html Msg
rowSegment widthPercentage children =
    -- div [ styleRowSegment widthPercentage ] children
    div  (styleRowSegment  widthPercentage)  children
