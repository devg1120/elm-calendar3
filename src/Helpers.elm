module Helpers exposing (..)

-- import Date exposing (Date)
-- import Date.Extra (Time.Extra)
-- import Date
-- import Time.Extra exposing (Month(..), utc)

import Date
import Time
import Time.Extra
import List.Extra
import String


hourString : Time.Posix -> String
hourString posix =
    let 
      -- date =  Date.fromPosix Time.utc posix
      hh = String.fromInt (Time.toHour Time.utc posix)
      mm = String.fromInt (Time.toMinute Time.utc posix)
    in
      -- Date.format "h:mm a" date
      hh ++ ":" ++ "00"


bumpMidnightBoundary :Time.Posix -> Time.Posix
bumpMidnightBoundary posix =
     let
         date = Date.fromPosix Time.utc posix 
     in
         if Date.ordinalDay date == 0 then
             Time.Extra.add Time.Extra.Millisecond 1 Time.utc posix
         else
             posix

{-
hours :Time.Posix -> List Time.Posix
hours posix =
    let
        posix_day =
            bumpMidnightBoundary posix

        day =  Date.fromPosix Time.utc posix_day

        midnight =
           Time.millisToPosix (Date.toRataDie  (Date.floor Date.Day day))

        lastHour =
           Time.millisToPosix (Date.toRataDie  (Date.ceiling Date.Day day))

        -- outlist = Time.Extra.range  Time.Extra.Hour 1 Time.utc  midnight lastHour
    in
        -- Date.range Date.Hour 1 midnight lastHour
        -- outlist = Time.Extra.range Time.Extra.Hour 1 midnight lastHour
        -- List.map Date.fromRataDie (List.map Time.posixToMillis  outlist)
        Time.Extra.range  Time.Extra.Hour 1 Time.utc  midnight lastHour
-}

hours :Time.Posix -> List Time.Posix
hours posix =
    let
        start = Time.Extra.floor Time.Extra.Day  Time.utc posix
        last  = Time.Extra.add   Time.Extra.Hour 24  Time.utc start
    in
        Time.Extra.range  Time.Extra.Hour 1 Time.utc   start last

weekRangesFromMonth : Int ->Time.Month -> List (List Time.Posix)
weekRangesFromMonth year month =
    let
        firstOfMonth =
            -- Date.fromCalendarDate year month 1
            Time.Extra.partsToPosix Time.utc (Time.Extra.Parts year month 1 0 0 0 0)

        firstOfNextMonth =
            -- Date.add  Date.Months 1  firstOfMonth
            Time.Extra.add Time.Extra.Month 1 Time.utc firstOfMonth
    in
        -- Date.range Date.Day
        Time.Extra.range  Time.Extra.Day
            1
            Time.utc
            (Time.Extra.floor  Time.Extra.Sunday Time.utc firstOfMonth)
            (Time.Extra.ceiling Time.Extra.Sunday Time.utc firstOfNextMonth)
            |> List.Extra.groupsOf 7


-- dayRangeOfWeek : Date.Date -> List Date.Date
dayRangeOfWeek : Time.Posix -> List Time.Posix
dayRangeOfWeek posix =
    -- Date.range Date.Day
    --     1
    --     (Date.floor Date.Sunday date)
    --     (Date.ceiling Date.Sunday date)
    Time.Extra.range  Time.Extra.Day
         1
         Time.utc
         (Time.Extra.floor  Time.Extra.Sunday Time.utc posix)
         (Time.Extra.ceiling Time.Extra.Sunday Time.utc posix)
