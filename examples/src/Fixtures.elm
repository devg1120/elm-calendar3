module Fixtures exposing (..)

-- import Date exposing (..)
-- import Date.Extra as Date exposing (..)
import Time
import Time.Extra
import Date

{-
start : Time.Posix
start =
    Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 14 30 0 0)


end : Time.Posix
end =
    Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 20 30 0 0)


dayPrior : Time.Posix
dayPrior =
    Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 3 14 30 0 0)


dayAfter : Time.Posix
dayAfter =
    Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 5 14 30 0 0)


weekPrior : Time.Posix
weekPrior =
    Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Sep 27 14 30 0 0)


weekAfter : Time.Posix
weekAfter =
    Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 11 14 30 0 0)

-}

--viewing : Time.Posix
--viewing =
--    Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 9 16 0 0 0) -- use MONTH WEEK DAY


{-
fullWeekStartSunday : List Date.Date
fullWeekStartSunday =
    [ Date.fromCalendarDate 2016 Time.Oct 2
    , Date.fromCalendarDate 2016 Time.Oct 3
    , Date.fromCalendarDate 2016 Time.Oct 4
    , Date.fromCalendarDate 2016 Time.Oct 5
    , Date.fromCalendarDate 2016 Time.Oct 6
    , Date.fromCalendarDate 2016 Time.Oct 7
    , Date.fromCalendarDate 2016 Time.Oct 8
    ]


octoberDatesByWeek : List (List Date.Date)
octoberDatesByWeek =
    [ [ Date.fromCalendarDate 2016 Time.Sep 25
      , Date.fromCalendarDate 2016 Time.Sep 26
      , Date.fromCalendarDate 2016 Time.Sep 27
      , Date.fromCalendarDate 2016 Time.Sep 28
      , Date.fromCalendarDate 2016 Time.Sep 29
      , Date.fromCalendarDate 2016 Time.Sep 30
      , Date.fromCalendarDate 2016 Time.Oct 1
      ]
    , [ Date.fromCalendarDate 2016 Time.Oct 2
      , Date.fromCalendarDate 2016 Time.Oct 3
      , Date.fromCalendarDate 2016 Time.Oct 4
      , Date.fromCalendarDate 2016 Time.Oct 5
      , Date.fromCalendarDate 2016 Time.Oct 6
      , Date.fromCalendarDate 2016 Time.Oct 7
      , Date.fromCalendarDate 2016 Time.Oct 8
      ]
    , [ Date.fromCalendarDate 2016 Time.Oct 9
      , Date.fromCalendarDate 2016 Time.Oct 10
      , Date.fromCalendarDate 2016 Time.Oct 11
      , Date.fromCalendarDate 2016 Time.Oct 12
      , Date.fromCalendarDate 2016 Time.Oct 13
      , Date.fromCalendarDate 2016 Time.Oct 14
      , Date.fromCalendarDate 2016 Time.Oct 15
      ]
    , [ Date.fromCalendarDate 2016 Time.Oct 16
      , Date.fromCalendarDate 2016 Time.Oct 17
      , Date.fromCalendarDate 2016 Time.Oct 18
      , Date.fromCalendarDate 2016 Time.Oct 19
      , Date.fromCalendarDate 2016 Time.Oct 20
      , Date.fromCalendarDate 2016 Time.Oct 21
      , Date.fromCalendarDate 2016 Time.Oct 22
      ]
    , [ Date.fromCalendarDate 2016 Time.Oct 23
      , Date.fromCalendarDate 2016 Time.Oct 24
      , Date.fromCalendarDate 2016 Time.Oct 25
      , Date.fromCalendarDate 2016 Time.Oct 26
      , Date.fromCalendarDate 2016 Time.Oct 27
      , Date.fromCalendarDate 2016 Time.Oct 28
      , Date.fromCalendarDate 2016 Time.Oct 29
      ]
    , [ Date.fromCalendarDate 2016 Time.Oct 30
      , Date.fromCalendarDate 2016 Time.Oct 31
      , Date.fromCalendarDate 2016 Time.Nov 1
      , Date.fromCalendarDate 2016 Time.Nov 2
      , Date.fromCalendarDate 2016 Time.Nov 3
      , Date.fromCalendarDate 2016 Time.Nov 4
      , Date.fromCalendarDate 2016 Time.Nov 5
      ]
    ]


hoursInADay : List Time.Posix
hoursInADay =
    [ Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 0 0 0 0)
    , Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 1 0 0 0)
    , Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 2 0 0 0)
    , Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 3 0 0 0)
    , Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 4 0 0 0)
    , Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 5 0 0 0)
    , Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 6 0 0 0)
    , Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 7 0 0 0)
    , Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 8 0 0 0)
    , Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 9 0 0 0)
    , Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 10 0 0 0)
    , Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 11 0 0 0)
    , Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 12 0 0 0)
    , Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 13 0 0 0)
    , Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 14 0 0 0)
    , Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 15 0 0 0)
    , Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 16 0 0 0)
    , Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 17 0 0 0)
    , Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 18 0 0 0)
    , Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 19 0 0 0)
    , Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 20 0 0 0)
    , Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 21 0 0 0)
    , Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 22 0 0 0)
    , Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 4 23 0 0 0)
    ]

-}
{--
eventOne =
    { id = "1", title = "GUSA 1/ Friends", start = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 9 3 0 0 0), end = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 9 5 0 0 0) }


eventTwo =
    { id = "2", title = "GUSA2/ Friends", start = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 9 12 0 0 0), end = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 9 13 0 0 0) }


eventThree =
    { id = "3", title = "GUSA3/ Friends", start = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 9 17 0 0 0), end = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 9 20 0 0 0) }


eventFour =
    { id = "4", title = "GUSA4/ Friends", start = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 10 4 0 0 0), end = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 10 7 0 0 0) }

eventFive =
    { id = "5", title = "GUSA5/ Friends", start = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 11 4 0 0 0), end = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 11 7 0 0 0) }
    --}
    {--
eventGroups = []
--}
{--
eventGroups =
    [ { date = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 9 15 0 0 0)
      , events = [ eventOne ]
      }
    , { date = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 5 0 0 0 0)
      , events = [ eventTwo, eventThree ]
      }
    , { date = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 18 0 0 0 0)
      , events = [ eventFour ]
      }
    ]
    --}
    {--
events =
    [ eventOne
    , eventTwo
    , eventThree
    , eventFour
    , eventFive
    ]
    --}

--e01 =  { id = "1", title = "1", start = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 1 3 0 0 0), end = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 1 5 0 0 0) }

--e02 =  { id = "1", title = "1", start = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 1 3 0 0 0), end = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 1 5 0 0 0) }

type alias Event =
               {
                id    : String
               ,title : String
               ,start : Time.Posix
               ,end   : Time.Posix
                }


evt : Int -> String -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> Event
evt id title yyyy mm dd shh smm ehh emm =
    let
       id_ = String.fromInt id
       start_ = Time.Extra.partsToPosix Time.utc 
               (Time.Extra.Parts  yyyy 
               (Date.numberToMonth mm) dd shh smm 0 0)
       end_   = Time.Extra.partsToPosix Time.utc 
               (Time.Extra.Parts  yyyy 
               (Date.numberToMonth mm) dd ehh emm 0 0)
    in
    Event id_ title start_ end_



viewing : Time.Posix
viewing =
    Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 1 16 0 0 0) -- use MONTH WEEK DAY
e01 = evt  1 "id 1"  2020 10  1 3 0 5 0
e02 = evt  2 "id 2"  2020 10  2 3 0 5 0
e03 = evt  3 "id 3"  2020 10  3 3 0 5 0
e04 = evt  4 "id 4"  2020 10  4 3 0 5 0
e05 = evt  5 "id 5"  2020 10  5 3 0 5 0
e06 = evt  6 "id 6"  2020 10  6 3 0 5 0
e07 = evt  7 "id 7"  2020 10  7 3 0 5 0

e08 = evt  8 "id 8"  2020 10  8 3 0 5 0
e09 = evt  9 "id 9"  2020 10  9 3 0 5 0
e10 = evt 10 "id 10" 2020 10 10 3 0 5 0
e11 = evt 11 "id 11" 2020 10 11 3 0 5 0
e12 = evt 12 "id 12" 2020 10 12 3 0 5 0
e13 = evt 13 "id 13" 2020 10 13 3 0 5 0
e14 = evt 14 "id 14" 2020 10 14 3 0 5 0

e15 = evt 15 "id 15" 2020 10 15 3 0 5 0
e16 = evt 16 "id 16" 2020 10 16 3 0 5 0
e17 = evt 17 "id 17" 2020 10 17 3 0 5 0
e18 = evt 18 "id 18" 2020 10 18 3 0 5 0
e19 = evt 19 "id 19" 2020 10 19 3 0 5 0
e20 = evt 20 "id 20" 2020 10 20 3 0 5 0
e21 = evt 21 "id 21" 2020 10 21 3 0 5 0

e22 = evt 22 "id 22" 2020 10 22 3 0 5 0
e23 = evt 23 "id 23" 2020 10 23 3 0 5 0
e24 = evt 24 "id 24" 2020 10 24 3 0 5 0
e25 = evt 25 "id 25" 2020 10 25 3 0 5 0
e26 = evt 26 "id 26" 2020 10 26 3 0 5 0
e27 = evt 27 "id 27" 2020 10 27 3 0 5 0
e28 = evt 28 "id 28" 2020 10 28 3 0 5 0

e29 = evt 29 "id 29" 2020 10 29 3 0 5 0
e30 = evt 30 "id 30" 2020 10 30 3 0 5 0
e31 = evt 31 "id 31" 2020 10 31 3 0 5 0

e122 = evt 122 "id 122" 2020 10 22 6 0 7 0
e123 = evt 123 "id 123" 2020 10 23 6 0 7 0
e124 = evt 124 "id 124" 2020 10 24 6 0 7 0
e125 = evt 125 "id 125" 2020 10 25 6 0 7 0
e126 = evt 126 "id 126" 2020 10 26 6 0 7 0
e127 = evt 127 "id 127" 2020 10 27 6 0 7 0
e128 = evt 128 "id 128" 2020 10 28 6 0 7 0

allday1 =  { id = "all_1", title = "all_1", start = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 1 3 0 0 0), end = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 2 5 0 0 0) }
allday2 =  { id = "all_2", title = "all_2", start = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 2 3 0 0 0), end = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 3 5 0 0 0) }
allday3 =  { id = "all_3", title = "all_3", start = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 12 3 0 0 0), end = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 16 5 0 0 0) }
allday4 =  { id = "all_4", title = "all_4", start = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 18 3 0 0 0), end = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 20 5 0 0 0) }
allday5 =  { id = "all_5", title = "all_5", start = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 5 3 0 0 0), end = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 6 5 0 0 0) }
allday6 =  { id = "all_6", title = "all_6", start = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 8 3 0 0 0), end = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 9 5 0 0 0) }

events =
    [ e01 , e02 , e03 , e04 , e05 , e06 , e07
    , e08 , e09 , e10 , e11 , e12 , e13 , e14
    , e15 , e16 , e17 , e18 , e19 , e20 , e21
    , e22 , e23 , e24 , e25 , e26 , e27 , e28
    , e122 , e123 , e124 , e125 , e126 , e127 , e128
    , e29 , e30 , e31 
    , allday1, allday2, allday3 , allday4
    , allday5, allday6
    ]

--eventGroups = []
{--
eventGroups =
    [ { date = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 9 15 0 0 0)
      , events = [ eventOne ]
      }
    , { date = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 5 0 0 0 0)
      , events = [ eventTwo, eventThree ]
      }
    , { date = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2016 Time.Oct 18 0 0 0 0)
      , events = [ eventFour ]
      }
    ]
    --}
