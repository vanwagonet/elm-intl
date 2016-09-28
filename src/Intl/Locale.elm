module Intl.Locale exposing
  ( Locale
  , fromString
  , toString
  , en, zhCN, zhTW, fr, de, it, ja, ko
  )

{-| A Locale represents a BCP-47 language tag including optional region,
variant, and extensions.

@docs Locale, fromString, toString
-}

import Native.Intl.Locale


{-| The Locale type holds a valid BCP-47 language tag.
-}
type Locale =
  Locale String


{-| Checks the string as a valid language tag, and returns a locale if it is.
-}
fromString : String -> Maybe Locale
fromString =
  Native.Intl.Locale.fromString


{-| Gets the string language tag from a Locale
-}
toString : Locale -> String
toString locale =
  case locale of
    Locale tag -> tag


{-| English -}
en : Locale
en =
  Locale "en"

{-| Simplified Chinese -}
zhCN : Locale
zhCN =
  Locale "zh-CN"

{-| Traditional Chinese -}
zhTW : Locale
zhTW =
  Locale "zh-TW"

{-| French -}
fr : Locale
fr =
  Locale "fr"

{-| German -}
de : Locale
de =
  Locale "de"

{-| Italian -}
it : Locale
it =
  Locale "it"

{-| Japanese -}
ja : Locale
ja =
  Locale "ja"

{-| Korean -}
ko : Locale
ko =
  Locale "ko"
