module Test.PluralRules exposing (all)

import Test exposing (..)
import Expect
import Intl.PluralRules as PluralRules
import Intl.Locale as Locale
import Intl.Currency as Currency
import List exposing (map, concat, length)
import Maybe exposing (Maybe(Just), withDefault)


all : Test
all =
    let
        select =
            PluralRules.select (PluralRules.fromLocale Locale.en)

        fromLocaleTests =
            describe "fromLocale"
                [ test "selects plural form for 1" <|
                    \() ->
                        Expect.equal (select 1) "one"
                , test "selects plural form for 1.1" <|
                    \() ->
                        Expect.equal (select 1.1) "other"
                , test "selects plural form for 2" <|
                    \() ->
                        Expect.equal (select 2) "other"
                ]

        supportedLocalesOfTests =
            describe "supportedLocalesOf"
                [ test "at least one predefined locale is supported" <|
                    \() ->
                        Expect.atLeast 1
                            (length (PluralRules.supportedLocalesOf predefinedLocales))
                , test "not all locales are supported" <|
                    \() ->
                        Expect.equal
                            (PluralRules.supportedLocalesOf
                                [ withDefault Locale.en (Locale.fromLanguageTag "tlh")
                                  -- Klingon
                                , withDefault Locale.en (Locale.fromLanguageTag "qya")
                                  -- Elvish
                                ]
                            )
                            []
                ]
    in
        describe "Intl.PluralRules"
            [ fromLocaleTests
            , supportedLocalesOfTests
            ]


predefinedLocales : List Locale.Locale
predefinedLocales =
    [ Locale.en
    , Locale.zhCN
    ]
