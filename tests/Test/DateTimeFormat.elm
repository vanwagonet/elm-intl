module Test.DateTimeFormat exposing (all)

import Test exposing (..)
import Expect
import Intl.DateTimeFormat as DateTimeFormat
import Intl.Locale as Locale
import Intl.TimeZone exposing (utc)
import List exposing (map, concat, length)
import String exposing (startsWith)
import Maybe exposing (Maybe(Just), withDefault)
import Date
import Time exposing (second)


all : Test
all =
    let
        fromLocaleTests =
            describe "fromLocale and format"
                [ test "English" <|
                    \() ->
                        let
                            format =
                                DateTimeFormat.format (DateTimeFormat.fromLocale Locale.en)
                        in
                            Expect.equal
                                (format (Date.fromTime (1482683025 * second)))
                                "12/25/2016"
                ]

        formatTests =
            describe "format"
                (let
                    defaults =
                        DateTimeFormat.defaults

                    christmas =
                        -- 2016/12/25, 16:23:45 UTC
                        (Date.fromTime (1482683025 * second))

                    format dt opts =
                        DateTimeFormat.format (DateTimeFormat.fromOptions opts) dt
                 in
                    [ test "timeZone" <|
                        \() ->
                            Expect.equal
                                (format christmas
                                    { defaults
                                        | timeZone = Just utc
                                        , timeZoneName = DateTimeFormat.ShortTimeZone
                                        , weekday = DateTimeFormat.LongName
                                    }
                                )
                                "Sunday, UTC"
                    , test "hour12" <|
                        \() ->
                            Expect.equal
                                (format christmas
                                    { defaults
                                        | hour12 = Just True
                                        , hour = DateTimeFormat.NumericNumber
                                        , timeZone = Just utc
                                    }
                                )
                                "4 PM"
                    , test "weekday" <|
                        \() ->
                            Expect.equal
                                (format christmas { defaults | weekday = DateTimeFormat.LongName })
                                "Sunday"
                    , test "era" <|
                        \() ->
                            Expect.equal
                                (format christmas
                                    { defaults
                                        | era = DateTimeFormat.ShortName
                                        , year = DateTimeFormat.NumericNumber
                                    }
                                )
                                "2016 AD"
                    , test "year" <|
                        \() ->
                            Expect.equal
                                (format christmas { defaults | year = DateTimeFormat.NumericNumber })
                                "2016"
                    , test "month" <|
                        \() ->
                            Expect.equal
                                (format christmas { defaults | month = DateTimeFormat.LongMonth })
                                "December"
                    , test "day" <|
                        \() ->
                            Expect.equal
                                (format christmas { defaults | day = DateTimeFormat.NumericNumber })
                                "25"
                    , test "hour" <|
                        \() ->
                            Expect.equal
                                (format christmas
                                    { defaults
                                        | hour = DateTimeFormat.NumericNumber
                                        , hour12 = Just False
                                        , timeZone = Just utc
                                    }
                                )
                                "16"
                    , test "minute" <|
                        \() ->
                            Expect.equal
                                (format christmas { defaults | minute = DateTimeFormat.NumericNumber })
                                "23"
                    , test "second" <|
                        \() ->
                            Expect.equal
                                (format christmas { defaults | second = DateTimeFormat.NumericNumber })
                                "45"
                    , test "timeZoneName" <|
                        \() ->
                            Expect.equal
                                (format christmas
                                    { defaults
                                        | timeZoneName = DateTimeFormat.LongTimeZone
                                        , timeZone = Just utc
                                        , year = DateTimeFormat.NumericNumber
                                    }
                                )
                                "2016, Coordinated Universal Time"
                    ]
                )

        fromOptionsTests =
            describe "fromOptions and resolvedOptions"
                (map
                    (\options ->
                        test ("options " ++ toString options) <|
                            \() ->
                                let
                                    resolved =
                                        DateTimeFormat.resolvedOptions (DateTimeFormat.fromOptions options)
                                in
                                    Expect.true "Expected resolved options to not have something match"
                                        (resolved.weekday
                                            == options.weekday
                                            || resolved.era
                                            == options.era
                                            || resolved.year
                                            == options.year
                                            || resolved.month
                                            == options.month
                                            || resolved.day
                                            == options.day
                                            || resolved.hour
                                            == options.hour
                                            || resolved.minute
                                            == options.minute
                                            || resolved.second
                                            == options.second
                                            || resolved.timeZoneName
                                            == options.timeZoneName
                                        )
                    )
                    optionCombinations
                )

        supportedLocalesOfTests =
            describe "supportedLocalesOf"
                [ test "at least one predefined locale is supported" <|
                    \() ->
                        Expect.atLeast 1
                            (length (DateTimeFormat.supportedLocalesOf predefinedLocales))
                , test "not all locales are supported" <|
                    \() ->
                        Expect.equal
                            (DateTimeFormat.supportedLocalesOf
                                [ withDefault Locale.en (Locale.fromLanguageTag "tlh")
                                  -- Klingon
                                , withDefault Locale.en (Locale.fromLanguageTag "qya")
                                  -- Elvish
                                ]
                            )
                            []
                ]

        defaultsTests =
            describe "defaults"
                [ test "end up being m/d/y" <|
                    \() ->
                        let
                            resolved =
                                DateTimeFormat.fromOptions defaults
                                    |> DateTimeFormat.resolvedOptions
                        in
                            Expect.true "mdy"
                                (resolved.year
                                    == DateTimeFormat.NumericNumber
                                    && resolved.month
                                    == DateTimeFormat.NumericMonth
                                    && resolved.day
                                    == DateTimeFormat.NumericNumber
                                )
                ]
    in
        describe "Intl.DateTimeFormat"
            [ fromLocaleTests
            , formatTests
            , fromOptionsTests
            , supportedLocalesOfTests
            , defaultsTests
            ]


defaults : DateTimeFormat.Options
defaults =
    DateTimeFormat.defaults


predefinedLocales : List Locale.Locale
predefinedLocales =
    [ Locale.en
    , Locale.zhCN
    , Locale.zhTW
    , Locale.fr
    , Locale.de
    , Locale.it
    , Locale.ja
    , Locale.ko
    ]



{- A couple commons configurations -}


optionCombinations : List DateTimeFormat.Options
optionCombinations =
    [ { defaults
        | weekday = DateTimeFormat.LongName
        , year = DateTimeFormat.NumericNumber
        , month = DateTimeFormat.LongMonth
        , day = DateTimeFormat.NumericNumber
        , hour = DateTimeFormat.NumericNumber
        , minute = DateTimeFormat.TwoDigitNumber
        , second = DateTimeFormat.TwoDigitNumber
      }
    , { defaults
        | weekday = DateTimeFormat.NarrowName
        , year = DateTimeFormat.NumericNumber
        , month = DateTimeFormat.NarrowMonth
        , day = DateTimeFormat.NumericNumber
      }
    , { defaults
        | year = DateTimeFormat.NumericNumber
        , month = DateTimeFormat.ShortMonth
        , day = DateTimeFormat.NumericNumber
      }
    , { defaults
        | year = DateTimeFormat.NumericNumber
        , month = DateTimeFormat.LongMonth
      }
    , { defaults
        | month = DateTimeFormat.LongMonth
        , day = DateTimeFormat.NumericNumber
      }
    , { defaults
        | hour = DateTimeFormat.NumericNumber
        , minute = DateTimeFormat.TwoDigitNumber
        , second = DateTimeFormat.TwoDigitNumber
      }
    , { defaults
        | hour12 = Just False
        , hour = DateTimeFormat.TwoDigitNumber
        , minute = DateTimeFormat.TwoDigitNumber
      }
    ]
