module Test.NumberFormat exposing (all)

import Test exposing (..)
import Expect
import Intl.NumberFormat as NumberFormat
import Intl.Locale as Locale
import Intl.Currency as Currency
import List exposing (map, concat, length)
import Maybe exposing (Maybe(Just), withDefault)


all : Test
all =
    let
        fromLocaleTests =
            describe "fromLocale"
                [ test "formats numbers" <|
                    \() ->
                        let
                            format =
                                NumberFormat.format (NumberFormat.fromLocale Locale.en)
                        in
                            Expect.equal (format 12345.6789) "12,345.679"
                ]

        fromOptionsTests =
            describe "specified options"
                [ let
                    options =
                        { defaults
                            | style = NumberFormat.PercentStyle
                            , maximumSignificantDigits = Just 3
                        }

                    format =
                        NumberFormat.format (NumberFormat.fromOptions options)

                    resolved =
                        NumberFormat.resolvedOptions (NumberFormat.fromOptions options)
                  in
                    describe "percent"
                        [ test "format" <|
                            \() -> Expect.equal (format 0.12345) "12.3%"
                        , test "resolvedOptions" <|
                            \() ->
                                Expect.equal
                                    resolved.maximumSignificantDigits
                                    options.maximumSignificantDigits
                        ]
                , let
                    options =
                        { defaults
                            | style = NumberFormat.PercentStyle
                            , minimumFractionDigits = Just 2
                        }

                    format =
                        NumberFormat.format (NumberFormat.fromOptions options)

                    resolved =
                        NumberFormat.resolvedOptions (NumberFormat.fromOptions options)
                  in
                    describe "percent"
                        [ test "format" <|
                            \() -> Expect.equal (format 1) "100.00%"
                        , test "resolvedOptions" <|
                            \() ->
                                Expect.equal
                                    resolved.minimumFractionDigits
                                    options.minimumFractionDigits
                        ]
                , let
                    options =
                        { defaults
                            | style = NumberFormat.CurrencyStyle
                            , currency = Currency.cad
                            , currencyDisplay = NumberFormat.CurrencyCode
                            , minimumFractionDigits = Just 2
                        }

                    format =
                        NumberFormat.format (NumberFormat.fromOptions options)

                    resolved =
                        NumberFormat.resolvedOptions (NumberFormat.fromOptions options)
                  in
                    describe "dollars"
                        [ test "format" <|
                            \() -> Expect.equal (format 42) "CAD42.00"
                        , test "resolvedOptions" <|
                            \() ->
                                Expect.equal
                                    resolved.currency
                                    options.currency
                        ]
                , let
                    options =
                        { defaults
                            | style = NumberFormat.CurrencyStyle
                            , currency = Currency.chf
                            , currencyDisplay = NumberFormat.CurrencyName
                        }

                    format =
                        NumberFormat.format (NumberFormat.fromOptions options)

                    resolved =
                        NumberFormat.resolvedOptions (NumberFormat.fromOptions options)
                  in
                    describe "francs"
                        [ test "format" <|
                            \() -> Expect.equal (format 42) "42.00 Swiss francs"
                        , test "resolvedOptions" <|
                            \() ->
                                Expect.equal
                                    resolved.currencyDisplay
                                    options.currencyDisplay
                        ]
                , let
                    options =
                        { defaults
                            | style = NumberFormat.CurrencyStyle
                            , currency = Currency.jpy
                            , currencyDisplay = NumberFormat.CurrencySymbol
                        }

                    format =
                        NumberFormat.format (NumberFormat.fromOptions options)

                    resolved =
                        NumberFormat.resolvedOptions (NumberFormat.fromOptions options)
                  in
                    describe "yen"
                        [ test "format" <|
                            \() -> Expect.equal (format 3456) "¥3,456"
                        , test "resolvedOptions" <|
                            \() ->
                                Expect.equal
                                    resolved.currencyDisplay
                                    options.currencyDisplay
                        ]
                , let
                    options =
                        { defaults
                            | minimumIntegerDigits = Just 2
                        }

                    format =
                        NumberFormat.format (NumberFormat.fromOptions options)

                    resolved =
                        NumberFormat.resolvedOptions (NumberFormat.fromOptions options)
                  in
                    describe "minimumIntegerDigits"
                        [ test "format" <|
                            \() -> Expect.equal (format 0.3456) "00.346"
                        , test "resolvedOptions" <|
                            \() ->
                                Expect.equal
                                    resolved.minimumIntegerDigits
                                    options.minimumIntegerDigits
                        ]
                , let
                    options =
                        { defaults
                            | minimumFractionDigits = Just 3
                        }

                    format =
                        NumberFormat.format (NumberFormat.fromOptions options)

                    resolved =
                        NumberFormat.resolvedOptions (NumberFormat.fromOptions options)
                  in
                    describe "minimumFractionDigits"
                        [ test "format" <|
                            \() -> Expect.equal (format 2) "2.000"
                        , test "resolvedOptions" <|
                            \() ->
                                Expect.equal
                                    resolved.minimumFractionDigits
                                    options.minimumFractionDigits
                        ]
                , let
                    options =
                        { defaults
                            | maximumFractionDigits = Just 1
                        }

                    format =
                        NumberFormat.format (NumberFormat.fromOptions options)

                    resolved =
                        NumberFormat.resolvedOptions (NumberFormat.fromOptions options)
                  in
                    describe "maximumFractionDigits"
                        [ test "format" <|
                            \() -> Expect.equal (format 0.1234) "0.1"
                        , test "resolvedOptions" <|
                            \() ->
                                Expect.equal
                                    resolved.maximumFractionDigits
                                    options.maximumFractionDigits
                        ]
                , let
                    options =
                        { defaults
                            | minimumSignificantDigits = Just 5
                        }

                    format =
                        NumberFormat.format (NumberFormat.fromOptions options)

                    resolved =
                        NumberFormat.resolvedOptions (NumberFormat.fromOptions options)
                  in
                    describe "minimumSignificantDigits"
                        [ test "format" <|
                            \() -> Expect.equal (format 0) "0.0000"
                        , test "resolvedOptions" <|
                            \() ->
                                Expect.equal
                                    resolved.minimumSignificantDigits
                                    options.minimumSignificantDigits
                        ]
                , let
                    options =
                        { defaults
                            | maximumSignificantDigits = Just 1
                        }

                    format =
                        NumberFormat.format (NumberFormat.fromOptions options)

                    resolved =
                        NumberFormat.resolvedOptions (NumberFormat.fromOptions options)
                  in
                    describe "maximumSignificantDigits"
                        [ test "format" <|
                            \() -> Expect.equal (format 123.456) "100"
                        , test "resolvedOptions" <|
                            \() ->
                                Expect.equal
                                    resolved.maximumSignificantDigits
                                    options.maximumSignificantDigits
                        ]
                ]

        supportedLocalesOfTests =
            describe "supportedLocalesOf"
                [ test "at least one predefined locale is supported" <|
                    \() ->
                        Expect.atLeast 1
                            (length (NumberFormat.supportedLocalesOf predefinedLocales))
                , test "not all locales are supported" <|
                    \() ->
                        Expect.equal
                            (NumberFormat.supportedLocalesOf
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
                [ test "ends up having specific options" <|
                    \() ->
                        let
                            resolved =
                                NumberFormat.fromOptions defaults
                                    |> NumberFormat.resolvedOptions
                        in
                            Expect.equal resolved
                                { defaults
                                    | maximumFractionDigits = Just 3
                                    , minimumFractionDigits = Just 0
                                    , minimumIntegerDigits = Just 1
                                }
                ]
    in
        describe "Intl.NumberFormat"
            [ fromLocaleTests
            , fromOptionsTests
            , supportedLocalesOfTests
            , defaultsTests
            ]


defaults : NumberFormat.Options
defaults =
    NumberFormat.defaults


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
