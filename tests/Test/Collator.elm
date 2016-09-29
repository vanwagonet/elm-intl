module Test.Collator exposing (all)

import Test exposing (..)
import Expect

import Intl.Collator as Collator
import Intl.Locale as Locale
import List exposing (map, concat, length)
import String exposing (startsWith)
import Maybe exposing (withDefault)

all : Test
all =
  let
    fromLocaleTests = describe "fromLocale and compare"
      ( map
        (\locale ->
          test (Locale.toString locale) <|
          \() ->
            let
              compare = Collator.compare (Collator.fromLocale locale)
            in
              Expect.equal
                [ compare "a" "z", compare "4" "4", compare "c" "a" ]
                [ LT, EQ, GT ]
        )
        predefinedLocales
      )
    fromOptionsTests = describe "fromOptions and resolvedOptions"
      ( map
        (\options ->
          test "options" <|
          \() ->
            let
              resolved = Collator.resolvedOptions (Collator.fromOptions options)
            in
              Expect.true "Expected resolved options to match options"
                ( resolved.usage == options.usage
                && resolved.sensitivity == options.sensitivity
                && resolved.ignorePunctuation == options.ignorePunctuation
                && resolved.numeric == options.numeric
                && resolved.caseFirst == options.caseFirst
                )
        )
        allOptionCombinations
      )
    supportedLocalesOfTests = describe "supportedLocalesOf"
      [ test "at least one predefined locale is supported" <|
        \() ->
          Expect.atLeast 1
            (length (Collator.supportedLocalesOf predefinedLocales))
      , test "not all locales are supported" <|
        \() ->
          Expect.equal
            ( Collator.supportedLocalesOf
              [ withDefault Locale.en (Locale.fromString "tlh") -- Klingon
              , withDefault Locale.en (Locale.fromString "qya") -- Elvish
              ]
            )
            []
      ]
  in
    describe "Intl.Collator"
      [ fromLocaleTests
      , fromOptionsTests
      , supportedLocalesOfTests
      ]


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

usages : List Collator.Usage
usages =
  [ Collator.Sort
  , Collator.Search
  ]

sensitivities : List Collator.Sensitivity
sensitivities =
  [ Collator.Base
  , Collator.Accent
  , Collator.Case
  , Collator.Variant
  ]

caseFirsts : List Collator.CaseFirst
caseFirsts =
  [ Collator.Upper
  , Collator.Lower
  , Collator.Default
  ]

bools =
  [ True
  , False
  ]

allOptionCombinations : List Collator.Options
allOptionCombinations =
  predefinedLocales |> map (\locale ->
    usages |> map (\usage ->
      sensitivities |> map (\sensitivity ->
        bools |> map (\ignorePunctuation ->
          bools |> map (\numeric ->
            caseFirsts |> map (\caseFirst ->
              { locale = locale
              , usage = usage
              , sensitivity = sensitivity
              , ignorePunctuation = ignorePunctuation
              , numeric = numeric
              , caseFirst = caseFirst
              }
            )
          ) |> List.concat
        ) |> List.concat
      ) |> List.concat
    ) |> List.concat
  ) |> List.concat
