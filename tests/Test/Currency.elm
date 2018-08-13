module Test.Currency exposing (all)

import Test exposing (..)
import Fuzz exposing (string)
import Expect
import Intl.Currency as Currency
import Maybe exposing (..)
import String exposing (toUpper)


all : Test
all =
    let
        fromCurrencyCodeTests =
            describe "fromCurrencyCode"
                [ test "empty string" <|
                    \() ->
                        Expect.equal (Currency.fromCurrencyCode "") Nothing
                , test "invalid characters" <|
                    \() ->
                        Expect.equal (Currency.fromCurrencyCode "$@#") Nothing
                , test "usd" <|
                    \() ->
                        Expect.equal (Currency.fromCurrencyCode "usd") (Just Currency.usd)
                , test "EUR" <|
                    \() ->
                        Expect.equal (Currency.fromCurrencyCode "EUR") (Just Currency.eur)
                , test "jpY" <|
                    \() ->
                        Expect.equal (Currency.fromCurrencyCode "jpY") (Just Currency.jpy)
                , test "gBp" <|
                    \() ->
                        Expect.equal (Currency.fromCurrencyCode "gBp") (Just Currency.gbp)
                , test "CHf" <|
                    \() ->
                        Expect.equal (Currency.fromCurrencyCode "CHf") (Just Currency.chf)
                , test "cAD" <|
                    \() ->
                        Expect.equal (Currency.fromCurrencyCode "cAD") (Just Currency.cad)
                , test "normalizes capitalization" <|
                    \() ->
                        Expect.equal
                            (Currency.fromCurrencyCode "xau"
                                |> withDefault Currency.cad
                                |> Currency.toCurrencyCode
                            )
                            "XAU"
                , fuzz string "doesn't crash on bad inputs" <|
                    \code ->
                        case Currency.fromCurrencyCode code of
                            Nothing ->
                                Expect.pass

                            Just _ ->
                                Expect.pass
                ]

        toCurrencyCodeTests =
            describe "toCurrencyCode"
                [ test "usd" <|
                    \() ->
                        Expect.equal (Currency.toCurrencyCode Currency.usd) "USD"
                , test "eur" <|
                    \() ->
                        Expect.equal (Currency.toCurrencyCode Currency.eur) "EUR"
                , test "jpy" <|
                    \() ->
                        Expect.equal (Currency.toCurrencyCode Currency.jpy) "JPY"
                , test "gbp" <|
                    \() ->
                        Expect.equal (Currency.toCurrencyCode Currency.gbp) "GBP"
                , test "chf" <|
                    \() ->
                        Expect.equal (Currency.toCurrencyCode Currency.chf) "CHF"
                , test "cad" <|
                    \() ->
                        Expect.equal (Currency.toCurrencyCode Currency.cad) "CAD"
                , fuzz string "doesn't crash on random Currencies" <|
                    \code ->
                        case Currency.fromCurrencyCode code of
                            Nothing ->
                                Expect.pass

                            Just currency ->
                                Expect.equal
                                    (Currency.toCurrencyCode currency)
                                    (toUpper code)
                ]
    in
        describe "Intl.Currency"
            [ fromCurrencyCodeTests
            , toCurrencyCodeTests
            ]
