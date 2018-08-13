module Intl.NumberFormat
    exposing
        ( NumberFormat
        , fromLocale
        , fromOptions
        , format
        , Options
        , Style(PercentStyle, CurrencyStyle, DecimalStyle)
        , CurrencyDisplay(CurrencyCode, CurrencyName, CurrencySymbol)
        , defaults
        , resolvedOptions
        , supportedLocalesOf
        )

{-| A library for formatting numbers in a language sensitve way. This module
binds to [Intl.NumberFormat](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/NumberFormat).

# Create
@docs NumberFormat, fromLocale, fromOptions

# Formatting Dates
@docs format

# Support and options

Not all environments will support all languages and options. These functions
help determine what is supported, and what options a particular NumberFormat will
use.

@docs Options, Style, CurrencyDisplay, defaults, resolvedOptions, supportedLocalesOf
-}

import Native.Intl.NumberFormat
import Intl.Locale exposing (Locale, en)
import Intl.Currency exposing (Currency, usd)
import Maybe exposing (Maybe)


{-| A NumberFormat object, for formatting numbers in a language sensitive way.
-}
type NumberFormat
    = NumberFormat


{-| Create a NumberFormat using rules from the specified language

    format (fromLocale "ar") 42
    -- "٤٢"
-}
fromLocale : Locale -> NumberFormat
fromLocale =
    Native.Intl.NumberFormat.fromLocale


{-| Create a NumberFormat using rules from the language and other options.

    let
      formatPercent = fromOptions
        { defaults |
        , style = PercentStyle
        , maximumSignificantDigits = Just 3
        }
        |> format
    in
      formatPercent 0.12345 -- 12.3%
-}
fromOptions : Options -> NumberFormat
fromOptions =
    Native.Intl.NumberFormat.fromOptions


{-| Format a number according to the rules of the NumberFormat.

    format (fromLocale Locale.en) 456789.123
-}
format : NumberFormat -> number -> String
format =
    Native.Intl.NumberFormat.format


{-| An Options record, containing the possible settings for a NumberFormat
object.

The min/max properties fall into two groups: `minimumIntegerDigits`,
`minimumFractionDigits`, and `maximumFractionDigits` in one group,
`minimumSignificantDigits` and `maximumSignificantDigits` in the other. If at
least one property from the second group is not `Nothing`, then the first group
is ignored.
-}
type alias Options =
    { locale : Locale
    , style : Style
    , currency : Currency
    , currencyDisplay : CurrencyDisplay
    , useGrouping : Bool
    , minimumIntegerDigits : Maybe Int
    , minimumFractionDigits : Maybe Int
    , maximumFractionDigits : Maybe Int
    , minimumSignificantDigits : Maybe Int
    , maximumSignificantDigits : Maybe Int
    }


{-| Style of the number format.
-}
type Style
    = PercentStyle
    | CurrencyStyle
    | DecimalStyle


{-| How to display the currency information.
-}
type CurrencyDisplay
    = CurrencyCode
    | CurrencyName
    | CurrencySymbol


{-| Returns the default options. This is helpful if you only care to change a
few options.

    options : Options
    options =
      { defaults | style = PercentStyle }
-}
defaults : Options
defaults =
    { locale = en
    , style = DecimalStyle
    , currency = usd
    , currencyDisplay = CurrencySymbol
    , useGrouping = True
    , minimumIntegerDigits = Nothing
    , minimumFractionDigits = Nothing
    , maximumFractionDigits = Nothing
    , minimumSignificantDigits = Nothing
    , maximumSignificantDigits = Nothing
    }


{-| Returns the locale and formatting options computed when the NumberFormat
was created.

    case (resolvedOptions numberFormat).style of
      CurrencyStyle -> "Total Money: "
      PercentStyle -> "Total Percent: "
      DecimalStyle -> "Total Quantity: "
-}
resolvedOptions : NumberFormat -> Options
resolvedOptions =
    Native.Intl.NumberFormat.resolvedOptions


{-| Returns a list from the provided languages that are supported without having
to fall back to the runtime's default language.

    case fromLanguageTag "tlh" of
      Just klingon ->
        if isEmpty (supportedLocalesOf [ klingon ]) then
          "I can't sort Klingon text"
        else
          "Make it so, Number One"
      Nothing ->
        "Khaaaaan!"
-}
supportedLocalesOf : List Locale -> List Locale
supportedLocalesOf =
    Native.Intl.NumberFormat.supportedLocalesOf
