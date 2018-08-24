# elm-intl [![Build Status](https://travis-ci.org/thetalecrafter/elm-intl.svg)](https://travis-ci.org/thetalecrafter/elm-intl)

```sh
elm package install thetalecrafter/elm-intl
```

This library contains bindings to the [Intl][Intl] ECMAScript
Internationalization API. Including `Collator`, `DateTimeFormat`, and
`NumberFormat`.

For environments that do not include the Internationalization API, you will
need to load a [polyfill][polyfill]. Node.js < 4 and Safari < 10 are known to
need the polyfill.

## Usage

First get a [Locale][Locale] to use:

```elm
import Intl.Locale exposing (Locale, fromLanguageTag, en)
import Maybe exposing (withDefault)

appLocale : Locale
appLocale =
  fromLanguageTag "pt-BR"
  |> withDefault en
```

You may then use it to create a [Collator][Collator],
[DateTimeFormat][DateTimeFormat], or [NumberFormat][NumberFormat]:

```elm
import Intl.Collator as Collator
import List exposing (sortWith)

localeCompare : String -> String -> Order
localeCompare =
  Collator.fromLocale appLocale
  |> Collator.compare

localeSort : List String -> List String
localeSort =
  sortWith localeCompare
```

```elm
import Intl.DateTimeFormat as DateTimeFormat

formatDate : Date -> String
formatDate =
  DateTimeFormat.fromLocale appLocale
  |> DateTimeFormat.format
```

```elm
import Intl.NumberFormat as NumberFormat

formatNumber : number -> String
formatNumber =
  NumberFormat.fromLocale appLocale
  |> NumberFormat.format
```

All of the Intl objects can be configured with more detailed options using
`fromOptions`. See the full [docs][docs] for more details.


[Intl]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl
[polyfill]: https://github.com/andyearnshaw/Intl.js
[Locale]: http://package.elm-lang.org/packages/thetalecrafter/elm-intl/latest/Intl.Locale
[Collator]: http://package.elm-lang.org/packages/thetalecrafter/elm-intl/latest/Intl.Collator
[DateTimeFormat]: http://package.elm-lang.org/packages/thetalecrafter/elm-intl/latest/Intl.DateTimeFormat
[NumberFormat]: http://package.elm-lang.org/packages/thetalecrafter/elm-intl/latest/Intl.NumberFormat
[docs]: http://elm-directory.herokuapp.com/package/vanwagonet/elm-intl/
