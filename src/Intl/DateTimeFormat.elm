module Intl.DateTimeFormat exposing
  ( DateTimeFormat
  , fromLocale
  , fromOptions
  , format
  , Options
  , MonthStyle(NarrowMonth, ShortMonth, LongMonth, NumericMonth, TwoDigitMonth, OmitMonth)
  , NameStyle(NarrowName, ShortName, LongName, OmitName)
  , NumberStyle(NumericNumber, TwoDigitNumber, OmitNumber)
  , TimeZoneStyle(ShortTimeZone, LongTimeZone, OmitTimeZone)
  , defaults
  , resolvedOptions
  , supportedLocalesOf
  )

{-| A library for formatting dates in a language sensitve way. This module
binds to [Intl.DateTimeFormat](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DateTimeFormat).

# Create
@docs DateTimeFormat, fromLocale, fromOptions

# Formatting Dates
@docs format

# Support and options

Not all environments will support all languages and options. These functions
help determine what is supported, and what options a particular DateTimeFormat will
use.

@docs Options, Style, defaults, resolvedOptions, supportedLocalesOf
-}

import Native.Intl.DateTimeFormat
import Intl.Locale exposing (Locale, en)
import Intl.TimeZone exposing (TimeZone)
import Maybe exposing (Maybe)
import Date exposing (Date)


{-| A DateTimeFormat object, for comparing strings in a language sensitive way.
-}
type DateTimeFormat = DateTimeFormat


{-| Create a DateTimeFormat using rules from the specified language

    format (fromLocale "pt-BR") christmas
    -- "25/12/2016"
-}
fromLocale : Locale -> DateTimeFormat
fromLocale =
  Native.Intl.DateTimeFormat.fromLocale


{-| Create a DateTimeFormat using rules from the language and other options.

    let
      formatTime = fromOptions
        { defaults |
        , locale = Locale.de
        , hour = Numeric
        , minute = TwoDigit
        }
        |> format
    in
      formatTime elevenPM -- 23:00
-}
fromOptions : Options -> DateTimeFormat
fromOptions =
  Native.Intl.DateTimeFormat.fromOptions


{-| Format a Date according to the rules of the DateTimeFormat.

    format (fromLocale Locale.en) Date.now
-}
format : DateTimeFormat -> Date -> String
format =
  Native.Intl.DateTimeFormat.format


{-| An Options record, containing the possible settings for a DateTimeFormat
object.
-}
type alias Options =
  { locale: Locale
  , timeZone: Maybe TimeZone
  , hour12: Maybe Bool
  , weekday: NameStyle
  , era: NameStyle
  , year: NumberStyle
  , month: MonthStyle
  , day: NumberStyle
  , hour: NumberStyle
  , minute: NumberStyle
  , second: NumberStyle
  , timeZoneName: TimeZoneStyle
  }


{-| Style options for the date parts that can be names.
-}
type NameStyle
  = NarrowName
  | ShortName
  | LongName
  | OmitName


{-| Style options for the date parts that can be numbers.
-}
type NumberStyle
  = NumericNumber
  | TwoDigitNumber
  | OmitNumber


{-| Style options for the month.
-}
type MonthStyle
  = NarrowMonth
  | ShortMonth
  | LongMonth
  | NumericMonth
  | TwoDigitMonth
  | OmitMonth


{-| Style options for the timeZoneName.
-}
type TimeZoneStyle
  = ShortTimeZone
  | LongTimeZone
  | OmitTimeZone


{-| Returns the default options. This is helpful if you only care to change a
few options. If all the date time parts are left ommitted, then `year`, `month`,
and `day` will be assumed numeric.

    options : Options
    options =
      { defaults | weekday = ShortName }
-}
defaults : Options
defaults =
  { locale = en
  , timeZone = Nothing
  , hour12 = Nothing
  , weekday = OmitName
  , era = OmitName
  , year = OmitNumber
  , month = OmitMonth
  , day = OmitNumber
  , hour = OmitNumber
  , minute = OmitNumber
  , second = OmitNumber
  , timeZoneName = OmitTimeZone
  }


{-| Returns the locale and formatting options computed when the DateTimeFormat
was created.

    if (resolvedOptions dateTimeFormat).hour12 then
      "AM/PM"
    else
      "Military Time"
-}
resolvedOptions : DateTimeFormat -> Options
resolvedOptions =
  Native.Intl.DateTimeFormat.resolvedOptions


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
  Native.Intl.DateTimeFormat.supportedLocalesOf
