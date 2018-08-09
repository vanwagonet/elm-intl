module Test.TimeZone exposing (all)

import Test exposing (..)
import Fuzz exposing (string)
import Expect
import Intl.TimeZone as TimeZone
import Maybe exposing (..)
import String exposing (toLower)


all : Test
all =
    let
        fromIANATimeZoneNameTests =
            describe "fromIANATimeZoneName"
                [ test "empty string" <|
                    \() ->
                        Expect.equal (TimeZone.fromIANATimeZoneName "") Nothing
                , test "invalid characters" <|
                    \() ->
                        Expect.equal (TimeZone.fromIANATimeZoneName "$@#") Nothing
                , test "utc" <|
                    \() ->
                        Expect.equal (TimeZone.fromIANATimeZoneName "utc") (Just TimeZone.utc)
                , test "maps Etc/UTC to UTC" <|
                    \() ->
                        Expect.equal (TimeZone.fromIANATimeZoneName "Etc/UTC") (Just TimeZone.utc)
                , test "canonicalizes time zones" <|
                    \() ->
                        Expect.equal
                            (TimeZone.fromIANATimeZoneName "Europe/Belfast"
                                |> withDefault TimeZone.utc
                                |> TimeZone.toIANATimeZoneName
                            )
                            "Europe/London"
                , test "normalizes capitalization" <|
                    \() ->
                        Expect.equal
                            (TimeZone.fromIANATimeZoneName "aMerIcA/BOISE"
                                |> withDefault TimeZone.utc
                                |> TimeZone.toIANATimeZoneName
                            )
                            "America/Boise"
                , fuzz string "doesn't crash on bad inputs" <|
                    \name ->
                        case TimeZone.fromIANATimeZoneName name of
                            Nothing ->
                                Expect.pass

                            Just _ ->
                                Expect.pass
                ]

        toIANATimeZoneNameTests =
            describe "toIANATimeZoneName"
                [ test "utc" <|
                    \() ->
                        Expect.equal (TimeZone.toIANATimeZoneName TimeZone.utc) "UTC"
                , fuzz string "doesn't crash on random TimeZones" <|
                    \name ->
                        case TimeZone.fromIANATimeZoneName name of
                            Nothing ->
                                Expect.pass

                            Just timeZone ->
                                Expect.equal
                                    (toLower (TimeZone.toIANATimeZoneName timeZone))
                                    (toLower name)
                ]
    in
        describe "Intl.TimeZone"
            [ fromIANATimeZoneNameTests
            , toIANATimeZoneNameTests
            ]
