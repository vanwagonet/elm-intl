module Test.Locale exposing (all)

import Test exposing (..)
import Fuzz exposing (string)
import Expect
import Intl.Locale as Locale
import Maybe exposing (..)
import String exposing (toLower)


all : Test
all =
    let
        fromLanguageTagTests =
            describe "fromLanguageTag"
                [ test "empty string" <|
                    \() ->
                        Expect.equal (Locale.fromLanguageTag "") Nothing
                , test "invalid characters" <|
                    \() ->
                        Expect.equal (Locale.fromLanguageTag "$@#") Nothing
                , test "en" <|
                    \() ->
                        Expect.equal (Locale.fromLanguageTag "en") (Just Locale.en)
                , test "zh-CN" <|
                    \() ->
                        Expect.equal (Locale.fromLanguageTag "zh-CN") (Just Locale.zhCN)
                , test "zh-tw" <|
                    \() ->
                        Expect.equal (Locale.fromLanguageTag "zh-tw") (Just Locale.zhTW)
                , test "fr" <|
                    \() ->
                        Expect.equal (Locale.fromLanguageTag "fr") (Just Locale.fr)
                , test "De" <|
                    \() ->
                        Expect.equal (Locale.fromLanguageTag "De") (Just Locale.de)
                , test "iT" <|
                    \() ->
                        Expect.equal (Locale.fromLanguageTag "iT") (Just Locale.it)
                , test "ja" <|
                    \() ->
                        Expect.equal (Locale.fromLanguageTag "ja") (Just Locale.ja)
                , test "ko" <|
                    \() ->
                        Expect.equal (Locale.fromLanguageTag "ko") (Just Locale.ko)
                , test "en-US" <|
                    \() ->
                        Expect.notEqual (Locale.fromLanguageTag "en-US") (Just Locale.en)
                , test "normalizes capitalization" <|
                    \() ->
                        Expect.equal
                            (Locale.fromLanguageTag "ZH-hant-hk"
                                |> withDefault Locale.en
                                |> Locale.toLanguageTag
                            )
                            "zh-Hant-HK"
                , fuzz string "doesn't crash on bad inputs" <|
                    \tag ->
                        case Locale.fromLanguageTag tag of
                            Nothing ->
                                Expect.pass

                            Just _ ->
                                Expect.pass
                ]

        toLanguageTagTests =
            describe "toLanguageTag"
                [ test "en" <|
                    \() ->
                        Expect.equal (Locale.toLanguageTag Locale.en) "en"
                , test "zh-CN" <|
                    \() ->
                        Expect.equal (Locale.toLanguageTag Locale.zhCN) "zh-CN"
                , test "zh-TW" <|
                    \() ->
                        Expect.equal (Locale.toLanguageTag Locale.zhTW) "zh-TW"
                , test "fr" <|
                    \() ->
                        Expect.equal (Locale.toLanguageTag Locale.fr) "fr"
                , test "de" <|
                    \() ->
                        Expect.equal (Locale.toLanguageTag Locale.de) "de"
                , test "it" <|
                    \() ->
                        Expect.equal (Locale.toLanguageTag Locale.it) "it"
                , test "ja" <|
                    \() ->
                        Expect.equal (Locale.toLanguageTag Locale.ja) "ja"
                , test "ko" <|
                    \() ->
                        Expect.equal (Locale.toLanguageTag Locale.ko) "ko"
                , fuzz string "doesn't crash on random locales" <|
                    \tag ->
                        case Locale.fromLanguageTag tag of
                            Nothing ->
                                Expect.pass

                            Just locale ->
                                Expect.equal
                                    (toLower (Locale.toLanguageTag locale))
                                    (toLower tag)
                ]
    in
        describe "Intl.Locale"
            [ fromLanguageTagTests
            , toLanguageTagTests
            ]
