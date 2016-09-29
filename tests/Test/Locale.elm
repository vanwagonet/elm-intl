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
    fromStringTests = describe "fromString"
      [ test "empty string" <|
        \() ->
          Expect.equal (Locale.fromString "") Nothing
      , test "invalid characters" <|
        \() ->
          Expect.equal (Locale.fromString "$@#") Nothing
      , test "en" <|
        \() ->
          Expect.equal (Locale.fromString "en") (Just Locale.en)
      , test "zh-CN" <|
        \() ->
          Expect.equal (Locale.fromString "zh-CN") (Just Locale.zhCN)
      , test "zh-tw" <|
        \() ->
          Expect.equal (Locale.fromString "zh-tw") (Just Locale.zhTW)
      , test "fr" <|
        \() ->
          Expect.equal (Locale.fromString "fr") (Just Locale.fr)
      , test "De" <|
        \() ->
          Expect.equal (Locale.fromString "De") (Just Locale.de)
      , test "iT" <|
        \() ->
          Expect.equal (Locale.fromString "iT") (Just Locale.it)
      , test "ja" <|
        \() ->
          Expect.equal (Locale.fromString "ja") (Just Locale.ja)
      , test "ko" <|
        \() ->
          Expect.equal (Locale.fromString "ko") (Just Locale.ko)
      , test "en-US" <|
        \() ->
          Expect.notEqual (Locale.fromString "en-US") (Just Locale.en)
      , test "normalizes capitalization" <|
        \() ->
          Expect.equal
            ( Locale.fromString "ZH-hant-hk"
              |> withDefault Locale.en
              |> Locale.toString
            )
            "zh-Hant-HK"
      , fuzz string "doesn't crash on bad inputs" <|
        \tag ->
          case Locale.fromString tag of
            Nothing -> Expect.pass
            Just _ -> Expect.pass
      ]

    toStringTests = describe "toString"
      [ test "en" <|
        \() ->
          Expect.equal (Locale.toString Locale.en) "en"
      , test "zh-CN" <|
        \() ->
          Expect.equal (Locale.toString Locale.zhCN) "zh-CN"
      , test "zh-TW" <|
        \() ->
          Expect.equal (Locale.toString Locale.zhTW) "zh-TW"
      , test "fr" <|
        \() ->
          Expect.equal (Locale.toString Locale.fr) "fr"
      , test "de" <|
        \() ->
          Expect.equal (Locale.toString Locale.de) "de"
      , test "it" <|
        \() ->
          Expect.equal (Locale.toString Locale.it) "it"
      , test "ja" <|
        \() ->
          Expect.equal (Locale.toString Locale.ja) "ja"
      , test "ko" <|
        \() ->
          Expect.equal (Locale.toString Locale.ko) "ko"
      , fuzz string "doesn't crash on random locales" <|
        \tag ->
          case Locale.fromString tag of
            Nothing -> Expect.pass
            Just locale ->
              Expect.equal
                (toLower (Locale.toString locale))
                (toLower tag)
      ]
  in
    describe "Intl.Locale"
      [ fromStringTests
      , toStringTests
      ]
