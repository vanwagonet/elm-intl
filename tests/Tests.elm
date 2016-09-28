module Tests exposing (..)

import Test exposing (..)

import Test.Locale as Locale
import Test.Collator as Collator

all : Test
all =
  describe "Tests for Internationalization API bindings"
    [ Locale.all
    , Collator.all
    ]
