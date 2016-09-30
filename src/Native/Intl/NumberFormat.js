// import Native.Intl.Locale //
// import Intl.Locale //
// import Intl.Currency //

/* global
  F2
  _thetalecrafter$elm_intl$Native_Intl_Locale
  _thetalecrafter$elm_intl$Intl_Locale$Locale
  _thetalecrafter$elm_intl$Intl_Currency$Currency
  _thetalecrafter$elm_intl$Intl_NumberFormat$DecimalStyle
  _thetalecrafter$elm_intl$Intl_NumberFormat$CurrencyStyle
  _thetalecrafter$elm_intl$Intl_NumberFormat$PercentStyle
  _thetalecrafter$elm_intl$Intl_NumberFormat$CurrencySymbol
  _thetalecrafter$elm_intl$Intl_NumberFormat$CurrencyCode
  _thetalecrafter$elm_intl$Intl_NumberFormat$CurrencyName
  _elm_lang$core$Maybe$Just
  _elm_lang$core$Maybe$Nothing
*/
/* eslint-disable camelcase */

// eslint-disable-next-line
var _thetalecrafter$elm_intl$Native_Intl_NumberFormat = function () {
  // this will create an early error if Intl is not supported
  var NumberFormat = Intl.NumberFormat

  function styleToUnion (value) {
    switch (value) {
      case 'percent':
        return _thetalecrafter$elm_intl$Intl_NumberFormat$PercentStyle
      case 'currency':
        return _thetalecrafter$elm_intl$Intl_NumberFormat$CurrencyStyle
      case 'decimal':
      default:
        return _thetalecrafter$elm_intl$Intl_NumberFormat$DecimalStyle
    }
  }

  function styleFromUnion (value) {
    switch (value) {
      case _thetalecrafter$elm_intl$Intl_NumberFormat$PercentStyle:
        return 'percent'
      case _thetalecrafter$elm_intl$Intl_NumberFormat$CurrencyStyle:
        return 'currency'
      case _thetalecrafter$elm_intl$Intl_NumberFormat$DecimalStyle:
      default:
        return 'decimal'
    }
  }

  function currencyDisplayToUnion (value) {
    switch (value) {
      case 'code':
        return _thetalecrafter$elm_intl$Intl_NumberFormat$CurrencyCode
      case 'name':
        return _thetalecrafter$elm_intl$Intl_NumberFormat$CurrencyName
      case 'symbol':
      default:
        return _thetalecrafter$elm_intl$Intl_NumberFormat$CurrencySymbol
    }
  }

  function currencyDisplayFromUnion (value) {
    switch (value) {
      case _thetalecrafter$elm_intl$Intl_NumberFormat$CurrencyCode:
        return 'code'
      case _thetalecrafter$elm_intl$Intl_NumberFormat$CurrencyName:
        return 'name'
      case _thetalecrafter$elm_intl$Intl_NumberFormat$CurrencySymbol:
      default:
        return 'symbol'
    }
  }

  function maybeInt (number) {
    return number == null
      ? _elm_lang$core$Maybe$Nothing
      : _elm_lang$core$Maybe$Just(number)
  }

  function minMaxInt (min, max, value) {
    return value == null
      ? value
      : Math.min(Math.max(value, min), max)
  }

  function fromLocale (locale) {
    return new NumberFormat(locale._0)
  }

  function fromOptions (record) {
    var locale = record.locale._0
    var options = {
      style: styleFromUnion(record.style),
      currency: record.currency._0,
      currencyDisplay: currencyDisplayFromUnion(record.currencyDisplay),
      useGrouping: record.useGrouping,
      // Maybe Number if Just _0 is the number, if Nothing _0 is undefined
      minimumIntegerDigits: minMaxInt(1, 21, record.minimumIntegerDigits._0),
      minimumFractionDigits: minMaxInt(0, 20, record.minimumFractionDigits._0),
      maximumFractionDigits: minMaxInt(0, 20, record.maximumFractionDigits._0),
      minimumSignificantDigits: minMaxInt(1, 21, record.minimumSignificantDigits._0),
      maximumSignificantDigits: minMaxInt(1, 21, record.maximumSignificantDigits._0)
    }
    return new NumberFormat(locale, options)
  }

  function format (numberFormat, value) {
    return numberFormat.format(value)
  }

  function resolvedOptions (numberFormat) {
    var options = numberFormat.resolvedOptions()
    return {
      locale: _thetalecrafter$elm_intl$Intl_Locale$Locale(options.locale),
      style: styleToUnion(options.style),
      currency: _thetalecrafter$elm_intl$Intl_Currency$Currency(options.currency || 'USD'),
      currencyDisplay: currencyDisplayToUnion(options.currencyDisplay),
      useGrouping: options.useGrouping,
      minimumIntegerDigits: maybeInt(options.minimumIntegerDigits),
      minimumFractionDigits: maybeInt(options.minimumFractionDigits),
      maximumFractionDigits: maybeInt(options.maximumFractionDigits),
      minimumSignificantDigits: maybeInt(options.minimumSignificantDigits),
      maximumSignificantDigits: maybeInt(options.maximumSignificantDigits)
    }
  }

  function supportedLocalesOf (list) {
    return _thetalecrafter$elm_intl$Native_Intl_Locale
      .supportedLocalesOf(NumberFormat, list)
  }

  return {
    fromLocale: fromLocale,
    fromOptions: fromOptions,
    format: F2(format),
    resolvedOptions: resolvedOptions,
    supportedLocalesOf: supportedLocalesOf
  }
}()
