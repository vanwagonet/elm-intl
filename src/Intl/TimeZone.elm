module Intl.TimeZone exposing
  ( TimeZone
  , fromIANATimeZoneName
  , toIANATimeZoneName
  , utc
  )

{-| A TimeZone represents a time zone from the IANA database.

@docs TimeZone, fromIANATimeZoneName, toIANATimeZoneName

# Predefined TimeZones

The UTC time zones has been pre-defined for convenience. For additional time
zones, you will need to use an [IANA time zone name](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List).

@docs utc
-}

import Native.Intl.TimeZone


{-| The TimeZone type holds a valid IANA time zone.
-}
type TimeZone =
  TimeZone String


{-| Checks the string as a valid time zone, and returns a TimeZone if it is.

    -- Hawaii time
    fromIANATimeZoneName "Pacific/Honolulu"

If a string is passed that is not a valid time zone, `Nothing` will be returned.
The string is matched in a case-insensitive manner.
-}
fromIANATimeZoneName : String -> Maybe TimeZone
fromIANATimeZoneName =
  Native.Intl.TimeZone.fromIANATimeZoneName


{-| Gets the canonicalized string time zone name from a TimeZone.

    toIANATimeZoneName TimeZone.utc == "UTC"
-}
toIANATimeZoneName : TimeZone -> String
toIANATimeZoneName timeZone =
  case timeZone of
    TimeZone name -> name


{-| Coordinated Universal Time -}
utc : TimeZone
utc =
  TimeZone "UTC"
