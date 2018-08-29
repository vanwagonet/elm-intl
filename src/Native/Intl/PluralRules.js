// import Native.Intl.Locale //
// import Intl.Locale //

/* global
  F2
  _thetalecrafter$elm_intl$Native_Intl_Locale
*/
/* eslint-disable camelcase */

// eslint-disable-next-line
var _thetalecrafter$elm_intl$Native_Intl_PluralRules = function () {
  var PluralRules = Intl.PluralRules

  // Minimal dummy implementation to avoid crashes
  function PluralRulesStub (locales) {
    this.select = function (value) {
      return 'other'
    }
  }
  PluralRulesStub.supportedLocalesOf = function (list) {
    return []
  }

  if (PluralRules === undefined) {
    PluralRules = PluralRulesStub
  }

  function fromLocale (locale) {
    return new PluralRules(locale._0)
  }

  function select (pluralRules, value) {
    return pluralRules.select(value)
  }

  function supportedLocalesOf (list) {
    return _thetalecrafter$elm_intl$Native_Intl_Locale
      .supportedLocalesOf(PluralRules, list)
  }

  return {
    fromLocale: fromLocale,
    select: F2(select),
    supportedLocalesOf: supportedLocalesOf
  }
}()
