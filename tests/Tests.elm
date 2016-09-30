module Tests exposing (..)

import Test exposing (..)

import Test.Collator as Collator
import Test.Currency as Currency
import Test.Locale as Locale
import Test.TimeZone as TimeZone

all : Test
all =
  describe "Tests for Internationalization API bindings"
    [ Collator.all
    , Currency.all
    , Locale.all
    , TimeZone.all
    ]
