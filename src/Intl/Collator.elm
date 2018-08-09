module Intl.Collator
    exposing
        ( Collator
        , fromLocale
        , fromOptions
        , compare
        , Options
        , Usage(Sort, Search)
        , Sensitivity(Base, Accent, Case, Variant)
        , CaseFirst(Upper, Lower, Default)
        , defaults
        , resolvedOptions
        , supportedLocalesOf
        )

{-| A library for comparing strings in a language sensitve way. This module
binds to [Intl.Collator](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Collator).
Note that the [Intl.js](https://github.com/andyearnshaw/Intl.js/) polyfill does
*not* include `Intl.Collator`. In environments without `Intl.Collator` this
library will fall back to `String.prototype.localeCompare`, which will not
respect the locale and options passed in.

# Create
@docs Collator, fromLocale, fromOptions

# Comparing Strings
@docs compare

# Support and options

Not all environments will support all languages and options. These functions
help determine what is supported, and what options a particular Collator will
use.

@docs Options, Usage, Sensitivity, CaseFirst, defaults, resolvedOptions, supportedLocalesOf
-}

import Native.Intl.Collator
import Intl.Locale exposing (Locale, en)


{-| A Collator object, for comparing strings in a language sensitive way.
-}
type Collator
    = Collator


{-| Create a Collator using rules from the specified language

    compare (fromLocale "pt-BR") "Tudo" "Bem"
-}
fromLocale : Locale -> Collator
fromLocale =
    Native.Intl.Collator.fromLocale


{-| Create a Collator using rules from the language and other options.

    let
      naturalCompare = fromOptions
        { locale = Locale.en
        , usage = Sort
        , sensitivity = Base
        , ignorePunctuation = True
        , numeric = True
        , caseFirst = Default
        }
        |> compare
    in
      naturalCompare "123" "25" -- GT
-}
fromOptions : Options -> Collator
fromOptions =
    Native.Intl.Collator.fromOptions


{-| Compare two Strings according to the sort order of the Collator.

    compare (fromLocale Locale.en) "123" "25" -- LT
-}
compare : Collator -> String -> String -> Order
compare =
    Native.Intl.Collator.compare


{-| An Options record, containing the possible settings for a Collator object.
-}
type alias Options =
    { locale : Locale
    , usage : Usage
    , sensitivity : Sensitivity
    , ignorePunctuation : Bool
    , numeric : Bool
    , caseFirst : CaseFirst
    }


{-| Whether the comparison is for sorting or for searching for matching strings.
-}
type Usage
    = Sort
    | Search


{-| Which differences in the strings should lead to non-zero result values.
Possible values are:

* Base: Only strings that differ in base letters compare as unequal. Examples:
  `a ≠ b`, `a = á`, `a = A`.
* Accent: Only strings that differ in base letters or accents and other
  diacritic marks compare as unequal. Examples: `a ≠ b`, `a ≠ á`, `a = A`.
* Case: Only strings that differ in base letters or case compare as unequal.
  Examples: `a ≠ b`, `a = á`, `a ≠ A`.
* Variant: Strings that differ in base letters, accents and other diacritic
  marks, or case compare as unequal. Other differences may also be taken into
  consideration. Examples: `a ≠ b`, `a ≠ á`, `a ≠ A`.
-}
type Sensitivity
    = Base
    | Accent
    | Case
    | Variant


{-| Whether upper case or lower case should sort first, or use the default order
for the language.
-}
type CaseFirst
    = Upper
    | Lower
    | Default


{-| Returns the default options. This is helpful if you only care to change a
few options.

    options : Options
    options =
      { defaults | sensitivity = Base }
-}
defaults : Options
defaults =
    { locale = en
    , usage = Sort
    , sensitivity = Variant
    , ignorePunctuation = False
    , numeric = False
    , caseFirst = Default
    }


{-| Returns the locale and collation options computed when the Collator was
created.

    if (resolvedOptions collator).numeric then
      "Sorts numbers naturally"
    else
      "Sorts numbers lexically"
-}
resolvedOptions : Collator -> Options
resolvedOptions =
    Native.Intl.Collator.resolvedOptions


{-| Returns a list from the provided languages that are supported without having
to fall back to the runtime's default language.

    case fromLanguageTag "qya" of
      Just elvish ->
        if isEmpty (supportedLocalesOf [ elvish ]) then
          "I can't sort Elvish text"
        else
          "Tolkien is #1"
      Nothing ->
        "You shall not pass"
-}
supportedLocalesOf : List Locale -> List Locale
supportedLocalesOf =
    Native.Intl.Collator.supportedLocalesOf
