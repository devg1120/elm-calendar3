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

viewing : Time.Posix
viewing =
    Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 9 16 0 0 0) -- use MONTH WEEK DAY


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

eventOne =
    { id = "1", title = "GUSA1/ Friends", start = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 9 3 0 0 0), end = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 9 5 0 0 0) }


eventTwo =
    { id = "2", title = "GUSA2/ Friends", start = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 9 12 0 0 0), end = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 9 13 0 0 0) }


eventThree =
    { id = "3", title = "GUSA3/ Friends", start = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 9 17 0 0 0), end = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 9 20 0 0 0) }


eventFour =
    { id = "4", title = "GUSA4/ Friends", start = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 9 4 0 0 0), end = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 9 7 0 0 0) }

eventFive =
    { id = "5", title = "GUSA5/ Friends", start = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 11 4 0 0 0), end = Time.Extra.partsToPosix Time.utc (Time.Extra.Parts  2020 Time.Oct 11 7 0 0 0) }


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


events =
    [ eventOne
    , eventTwo
    , eventThree
    , eventFour
    , eventFive
    ]

