module Intl.Locale
    exposing
        ( Locale
        , fromLanguageTag
        , toLanguageTag
        , en
        , zhCN
        , zhTW
        , fr
        , de
        , it
        , ja
        , ko
        )

{-| A Locale represents a BCP 47 language tag including optional script, region,
variant, and extensions.

@docs Locale, fromLanguageTag, toLanguageTag

# Predefined Locales

A few locales have been pre-defined for convenience.

@docs en, zhCN, zhTW, fr, de, it, ja, ko
-}

import Native.Intl.Locale


{-| The Locale type holds a valid BCP 47 language tag.
-}
type Locale
    = Locale String


{-| Checks the string as a valid language tag, and returns a locale if it is.

Unicode extensions can be added to the language tag that customize the behavior.
Although any explicit options used in `fromOptions` will take precendence over
the locale extensions.

    -- German Phone Book sorting
    fromLanguageTag "de-u-co-phonebk"

If a string is passed that is not a valid BCP 47 language tag, `Nothing` will be
returned.
-}
fromLanguageTag : String -> Maybe Locale
fromLanguageTag =
    Native.Intl.Locale.fromLanguageTag


{-| Gets the string language tag from a Locale

    toLanguageTag Locale.zhCN == "zh-CN"
-}
toLanguageTag : Locale -> String
toLanguageTag locale =
    case locale of
        Locale tag ->
            tag


{-| English
-}
en : Locale
en =
    Locale "en"


{-| Simplified Chinese
-}
zhCN : Locale
zhCN =
    Locale "zh-CN"


{-| Traditional Chinese
-}
zhTW : Locale
zhTW =
    Locale "zh-TW"


{-| French
-}
fr : Locale
fr =
    Locale "fr"


{-| German
-}
de : Locale
de =
    Locale "de"


{-| Italian
-}
it : Locale
it =
    Locale "it"


{-| Japanese
-}
ja : Locale
ja =
    Locale "ja"


{-| Korean
-}
ko : Locale
ko =
    Locale "ko"
