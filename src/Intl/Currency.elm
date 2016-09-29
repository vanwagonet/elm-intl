module Intl.Currency exposing
  ( Currency
  , fromCurrencyCode
  , toCurrencyCode
  , usd, eur, jpy, gbp, chf, cad
  )

{-| A Currency is used to the display numeric data as money. Note that
`NumberFormat` does *not* do exchange currency conversion, it only uses the
currency for displaying symbols and other conventions to mark the number as
money.

@docs Currency, fromCurrencyCode, toCurrencyCode

# Predefined Currencies

A few currencies have been pre-defined for convenience.

@docs usd, eur, jpy, gbp, chf, cad
-}

import Regex exposing (regex, contains)
import String exposing (toUpper)


{-| The Currency type holds a valid ISO 4217 currency code.
-}
type Currency =
  Currency String


{-| Checks the string as a valid currency code, and returns a currency if it is.

    -- Going back to the Gold Standard
    fromCurrencyCode "XAU"

If a string is passed that is not a valid currency code, `Nothing` will be
returned.

Note that any 3-letter string will work, but if it isn't a defined currency
code, then the formatting will have no symbol or currency name. It will just use
the code you provided.
-}
fromCurrencyCode : String -> Maybe Currency
fromCurrencyCode code =
  if contains (regex "^[A-Za-z]{3}$") code then
    Just (Currency (toUpper code))
  else
    Nothing


{-| Gets the string currency code from a Currency

    toCurrencyCode Currency.eur == "EUR"
-}
toCurrencyCode : Currency -> String
toCurrencyCode currency =
  case currency of
    Currency tag -> tag


{-| United States Dollar -}
usd : Currency
usd =
  Currency "USD"

{-| Euro -}
eur : Currency
eur =
  Currency "EUR"

{-| Japanese Yen -}
jpy : Currency
jpy =
  Currency "JPY"

{-| Pound Sterling -}
gbp : Currency
gbp =
  Currency "GBP"

{-| Swiss Franc -}
chf : Currency
chf =
  Currency "CHF"

{-| Canadian Dollar -}
cad : Currency
cad =
  Currency "CAD"
