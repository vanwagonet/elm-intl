module Intl.PluralRules
    exposing
        ( PluralRules
        , fromLocale
        , select
        , supportedLocalesOf
        )

{-| A library that enable plural sensitive formatting and plural language rules.
This module binds to [Intl.PluralRules](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/PluralRules).

# Create
@docs PluralRules

# Use
@docs select

# Support and options

@docs supportedLocalesOf
-}

import Native.Intl.PluralRules
import Intl.Locale as Locale


{-| A PluralRules object, for finding the correct plural form category
    for a number
-}
type PluralRules
    = PluralRules


{-| Creates a PluralRules object that contains the rules for a given locale
-}
fromLocale : Locale.Locale -> PluralRules
fromLocale =
    Native.Intl.PluralRules.fromLocale


{-| Given a PluralRules object and a number, returns the CLDR plural rules
category for that number
-}
select : PluralRules -> number -> String
select =
    Native.Intl.PluralRules.select


{-| Returns a list from the provided languages that are supported without having
to fall back to the runtime's default language.
-}
supportedLocalesOf : List Locale.Locale -> List Locale.Locale
supportedLocalesOf =
    Native.Intl.PluralRules.supportedLocalesOf
