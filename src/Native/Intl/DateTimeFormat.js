// import Native.Intl.Locale //
// import Intl.Locale //
// import Intl.TimeZone //

/* global
  F2
  _thetalecrafter$elm_intl$Native_Intl_Locale
  _thetalecrafter$elm_intl$Intl_Locale$Locale
  _thetalecrafter$elm_intl$Intl_TimeZone$TimeZone
  _thetalecrafter$elm_intl$Intl_DateTimeFormat$NarrowName
  _thetalecrafter$elm_intl$Intl_DateTimeFormat$ShortName
  _thetalecrafter$elm_intl$Intl_DateTimeFormat$LongName
  _thetalecrafter$elm_intl$Intl_DateTimeFormat$OmitName
  _thetalecrafter$elm_intl$Intl_DateTimeFormat$NumericNumber
  _thetalecrafter$elm_intl$Intl_DateTimeFormat$TwoDigitNumber
  _thetalecrafter$elm_intl$Intl_DateTimeFormat$OmitNumber
  _thetalecrafter$elm_intl$Intl_DateTimeFormat$NarrowMonth
  _thetalecrafter$elm_intl$Intl_DateTimeFormat$ShortMonth
  _thetalecrafter$elm_intl$Intl_DateTimeFormat$LongMonth
  _thetalecrafter$elm_intl$Intl_DateTimeFormat$NumericMonth
  _thetalecrafter$elm_intl$Intl_DateTimeFormat$TwoDigitMonth
  _thetalecrafter$elm_intl$Intl_DateTimeFormat$OmitMonth
  _thetalecrafter$elm_intl$Intl_DateTimeFormat$ShortTimeZone
  _thetalecrafter$elm_intl$Intl_DateTimeFormat$LongTimeZone
  _thetalecrafter$elm_intl$Intl_DateTimeFormat$OmitTimeZone
  _elm_lang$core$Maybe$Just
  _elm_lang$core$Maybe$Nothing
*/
/* eslint-disable camelcase */

// eslint-disable-next-line
var _thetalecrafter$elm_intl$Native_Intl_DateTimeFormat = function () {
  // this will create an early error if Intl is not supported
  var DateTimeFormat = Intl.DateTimeFormat

  function styleToName (value) {
    switch (value) {
      case 'narrow':
        return _thetalecrafter$elm_intl$Intl_DateTimeFormat$NarrowName
      case 'short':
        return _thetalecrafter$elm_intl$Intl_DateTimeFormat$ShortName
      case 'long':
        return _thetalecrafter$elm_intl$Intl_DateTimeFormat$LongName
      default:
        return _thetalecrafter$elm_intl$Intl_DateTimeFormat$OmitName
    }
  }

  function styleFromName (value) {
    switch (value) {
      case _thetalecrafter$elm_intl$Intl_DateTimeFormat$NarrowName:
        return 'narrow'
      case _thetalecrafter$elm_intl$Intl_DateTimeFormat$ShortName:
        return 'short'
      case _thetalecrafter$elm_intl$Intl_DateTimeFormat$LongName:
        return 'long'
      case _thetalecrafter$elm_intl$Intl_DateTimeFormat$OmitName:
      default:
    }
  }

  function styleToNumber (value) {
    switch (value) {
      case 'numeric':
        return _thetalecrafter$elm_intl$Intl_DateTimeFormat$NumericNumber
      case '2-digit':
        return _thetalecrafter$elm_intl$Intl_DateTimeFormat$TwoDigitNumber
      default:
        return _thetalecrafter$elm_intl$Intl_DateTimeFormat$OmitNumber
    }
  }

  function styleFromNumber (value) {
    switch (value) {
      case _thetalecrafter$elm_intl$Intl_DateTimeFormat$NumericNumber:
        return 'numeric'
      case _thetalecrafter$elm_intl$Intl_DateTimeFormat$TwoDigitNumber:
        return '2-digit'
      case _thetalecrafter$elm_intl$Intl_DateTimeFormat$OmitNumber:
      default:
    }
  }

  function styleToMonth (value) {
    switch (value) {
      case 'narrow':
        return _thetalecrafter$elm_intl$Intl_DateTimeFormat$NarrowMonth
      case 'short':
        return _thetalecrafter$elm_intl$Intl_DateTimeFormat$ShortMonth
      case 'long':
        return _thetalecrafter$elm_intl$Intl_DateTimeFormat$LongMonth
      case 'numeric':
        return _thetalecrafter$elm_intl$Intl_DateTimeFormat$NumericMonth
      case '2-digit':
        return _thetalecrafter$elm_intl$Intl_DateTimeFormat$TwoDigitMonth
      default:
        return _thetalecrafter$elm_intl$Intl_DateTimeFormat$OmitMonth
    }
  }

  function styleFromMonth (value) {
    switch (value) {
      case _thetalecrafter$elm_intl$Intl_DateTimeFormat$NarrowMonth:
        return 'narrow'
      case _thetalecrafter$elm_intl$Intl_DateTimeFormat$ShortMonth:
        return 'short'
      case _thetalecrafter$elm_intl$Intl_DateTimeFormat$LongMonth:
        return 'long'
      case _thetalecrafter$elm_intl$Intl_DateTimeFormat$NumericMonth:
        return 'numeric'
      case _thetalecrafter$elm_intl$Intl_DateTimeFormat$TwoDigitMonth:
        return '2-digit'
      case _thetalecrafter$elm_intl$Intl_DateTimeFormat$OmitMonth:
      default:
    }
  }

  function styleToTimeZone (value) {
    switch (value) {
      case 'short':
        return _thetalecrafter$elm_intl$Intl_DateTimeFormat$ShortTimeZone
      case 'long':
        return _thetalecrafter$elm_intl$Intl_DateTimeFormat$LongTimeZone
      default:
        return _thetalecrafter$elm_intl$Intl_DateTimeFormat$OmitTimeZone
    }
  }

  function styleFromTimeZone (value) {
    switch (value) {
      case _thetalecrafter$elm_intl$Intl_DateTimeFormat$ShortTimeZone:
        return 'short'
      case _thetalecrafter$elm_intl$Intl_DateTimeFormat$LongTimeZone:
        return 'long'
      case _thetalecrafter$elm_intl$Intl_DateTimeFormat$OmitTimeZone:
      default:
    }
  }

  function fromLocale (locale) {
    return new DateTimeFormat(locale._0)
  }

  function fromOptions (record) {
    var locale = record.locale._0
    var options = {
      timeZone: record.timeZone._0 && record.timeZone._0._0,
      hour12: record.hour12._0,
      weekday: styleFromName(record.weekday._0),
      era: styleFromName(record.era._0),
      year: styleFromNumber(record.year._0),
      month: styleFromMonth(record.month._0),
      day: styleFromNumber(record.day._0),
      hour: styleFromNumber(record.hour._0),
      minute: styleFromNumber(record.minute._0),
      second: styleFromNumber(record.second._0),
      timeZoneName: styleFromTimeZone(record.timeZoneName._0)
    }
    return new DateTimeFormat(locale, options)
  }

  function format (dateTimeFormat, value) {
    return dateTimeFormat.format(value)
  }

  function resolvedOptions (dateTimeFormat) {
    var options = dateTimeFormat.resolvedOptions()
    return {
      locale: _thetalecrafter$elm_intl$Intl_Locale$Locale(options.locale),
      timeZone: _elm_lang$core$Maybe$Just(
        _thetalecrafter$elm_intl$Intl_TimeZone$TimeZone(options.timeZone)
      ),
      hour12: options.hour12 == null
        ? _elm_lang$core$Maybe$Nothing
        : _elm_lang$core$Maybe$Just(options.hour12),
      weekday: styleToName(options.weekday),
      era: styleToName(options.era),
      year: styleToNumber(options.year),
      month: styleToMonth(options.month),
      day: styleToNumber(options.day),
      hour: styleToNumber(options.hour),
      minute: styleToNumber(options.minute),
      second: styleToNumber(options.second),
      timeZoneName: styleToTimeZone(options.timeZoneName)
    }
  }

  function supportedLocalesOf (list) {
    return _thetalecrafter$elm_intl$Native_Intl_Locale
      .supportedLocalesOf(DateTimeFormat, list)
  }

  return {
    fromLocale: fromLocale,
    fromOptions: fromOptions,
    format: F2(format),
    resolvedOptions: resolvedOptions,
    supportedLocalesOf: supportedLocalesOf
  }
}()
