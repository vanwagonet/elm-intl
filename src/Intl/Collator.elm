module Collator exposing
  ( Collator
  , fromLocale
  , fromOptions
  , compare
  , Options
  , Usage(Sort, Search)
  , Sensitivity(Base, Accent, Case, Variant)
  , CaseFirst()
  , resolvedOptions
  , supportedLocalesOf
  )

{-| A library for comparing strings in a language sensitve way. It uses the
[Intl.Collator](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Collator)
. For environments that do not include the Internationalization APIs, you will
need to load a [polyfill](https://github.com/andyearnshaw/Intl.js).

# Create
@docs Collator, fromLocale, fromOptions

# Comparing Strings
@docs compare

# Support and options

Not all environments will support all languages and options. These functions
help determine what is supported, and what options a particular Collator will
use.

@docs Options, Usage, Sensitivity, CaseFirst, resolvedOptions, supportedLocalesOf
-}

import Native.Intl.Collator


{-| A Collator object, for comparing strings in a language sensitive way.
-}
type Collator = Collator


{-| Create a Collator using rules from the specified language
-}
fromLocale : String -> Collator
fromLocale =
  Native.Intl.Collator.fromLocale


{-| Create a Collator using rules from the language and other options.
-}
fromOptions : Options -> Collator
fromOptions =
  Native.Intl.Collator.fromOptions


{-| Compare two Strings according to the sort order of the Collator.
-}
compare : String -> String -> Collator -> Order
compare =
  Native.Intl.Collator.compare


{-| An Options record, containing the possible settings for a Collator object.
-}
type alias Options =
  { locale: String
  , usage: Usage
  , sensitivity: Sensitivity
  , ignorePunctuation: Bool
  , numeric: Bool
  , caseFirst: CaseFirst
  }


{-| Whether the comparison is for sorting or for searching for matching strings.
-}
type Usage
  = Sort
  | Search


{-| Which differences in the strings should lead to non-zero result values.
Possible values are:

* Base: Only strings that differ in base letters compare as unequal. Examples:
  a ≠ b, a = á, a = A.
* Accent: Only strings that differ in base letters or accents and other
  diacritic marks compare as unequal. Examples: a ≠ b, a ≠ á, a = A.
* Case: Only strings that differ in base letters or case compare as unequal.
  Examples: a ≠ b, a = á, a ≠ A.
* Variant: Strings that differ in base letters, accents and other diacritic
  marks, or case compare as unequal. Other differences may also be taken into
  consideration. Examples: a ≠ b, a ≠ á, a ≠ A.
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


{-| Returns the locale and collation options computed when the Collator was
created.
-}
resolvedOptions : Collator -> Options
resolvedOptions =
  Native.Intl.Collator.resolvedOptions


{-| Returns a list from the provided languages that are supported without having
to fall back to the runtime's default language.
-}
supportedLocalesOf : List string -> List string
supportedLocalesOf =
  Native.Intl.Collator.supportedLocalesOf

