// import Native.Intl.Locale //
// import Intl.Locale //

/* global
  F3
  _thetalecrafter$elm_intl$Native_Intl_Locale
  _thetalecrafter$elm_intl$Intl_Locale$Locale
  _thetalecrafter$elm_intl$Intl_Collator$Search
  _thetalecrafter$elm_intl$Intl_Collator$Sort
  _thetalecrafter$elm_intl$Intl_Collator$Base
  _thetalecrafter$elm_intl$Intl_Collator$Accent
  _thetalecrafter$elm_intl$Intl_Collator$Case
  _thetalecrafter$elm_intl$Intl_Collator$Variant
  _thetalecrafter$elm_intl$Intl_Collator$Upper
  _thetalecrafter$elm_intl$Intl_Collator$Lower
  _thetalecrafter$elm_intl$Intl_Collator$Default
*/
/* eslint-disable camelcase */

// eslint-disable-next-line
var _thetalecrafter$elm_intl$Native_Intl_Collator = function () {
  // This will create an early error if Intl is not supported at all, and falls
  // back to a shim if Collator is missing from Intl.
  var Collator = Intl.Collator || (function () {
    function Collator () {}
    Collator.prototype = {
      compare: function (string1, string2) {
        return string1.localeCompare(string2)
      },
      resolvedOptions: function () {
        return {
          locale: 'x-shim',
          usage: 'sort',
          sensitivity: 'variant',
          ignorePunctuation: false,
          numeric: false,
          caseFirst: 'false'
        }
      }
    }
    Collator.supportedLocalesOf = function () {
      return [] // doesn't pretend to support any locale
    }
    return Collator
  }())

  function usageToUnion (value) {
    switch (value) {
      case 'search':
        return _thetalecrafter$elm_intl$Intl_Collator$Search
      case 'sort':
      default:
        return _thetalecrafter$elm_intl$Intl_Collator$Sort
    }
  }

  function usageFromUnion (value) {
    switch (value) {
      case _thetalecrafter$elm_intl$Intl_Collator$Search:
        return 'search'
      case _thetalecrafter$elm_intl$Intl_Collator$Sort:
      default:
        return 'sort'
    }
  }

  function sensitivityToUnion (value) {
    switch (value) {
      case 'base':
        return _thetalecrafter$elm_intl$Intl_Collator$Base
      case 'accent':
        return _thetalecrafter$elm_intl$Intl_Collator$Accent
      case 'case':
        return _thetalecrafter$elm_intl$Intl_Collator$Case
      case 'variant':
      default:
        return _thetalecrafter$elm_intl$Intl_Collator$Variant
    }
  }

  function sensitivityFromUnion (value) {
    switch (value) {
      case _thetalecrafter$elm_intl$Intl_Collator$Base:
        return 'base'
      case _thetalecrafter$elm_intl$Intl_Collator$Accent:
        return 'accent'
      case _thetalecrafter$elm_intl$Intl_Collator$Case:
        return 'case'
      case _thetalecrafter$elm_intl$Intl_Collator$Variant:
      default:
        return 'variant'
    }
  }

  function caseFirstToUnion (value) {
    switch (value) {
      case 'upper':
        return _thetalecrafter$elm_intl$Intl_Collator$Upper
      case 'lower':
        return _thetalecrafter$elm_intl$Intl_Collator$Lower
      case 'false':
      default:
        return _thetalecrafter$elm_intl$Intl_Collator$Default
    }
  }

  function caseFirstFromUnion (value) {
    switch (value) {
      case _thetalecrafter$elm_intl$Intl_Collator$Upper:
        return 'upper'
      case _thetalecrafter$elm_intl$Intl_Collator$Lower:
        return 'lower'
      case _thetalecrafter$elm_intl$Intl_Collator$Default:
      default:
        return 'false'
    }
  }

  function fromLocale (locale) {
    return new Collator(locale._0)
  }

  function fromOptions (record) {
    var locale = record.locale._0
    var options = {
      usage: usageFromUnion(record.usage),
      sensitivity: sensitivityFromUnion(record.sensitivity),
      ignorePunctuation: record.ignorePunctuation,
      numeric: record.numeric,
      caseFirst: caseFirstFromUnion(record.caseFirst)
    }
    return new Collator(locale, options)
  }

  function compare (collator, string1, string2) {
    var value = collator.compare(string1, string2)
    return { ctor: value === 0 ? 'EQ' : value < 0 ? 'LT' : 'GT' }
  }

  function resolvedOptions (collator) {
    var options = collator.resolvedOptions()
    return {
      locale: _thetalecrafter$elm_intl$Intl_Locale$Locale(options.locale),
      usage: usageToUnion(options.usage),
      sensitivity: sensitivityToUnion(options.sensitivity),
      ignorePunctuation: options.ignorePunctuation,
      numeric: options.numeric,
      caseFirst: caseFirstToUnion(options.caseFirst)
    }
  }

  function supportedLocalesOf (list) {
    return _thetalecrafter$elm_intl$Native_Intl_Locale
      .supportedLocalesOf(Collator, list)
  }

  return {
    fromLocale: fromLocale,
    fromOptions: fromOptions,
    compare: F3(compare),
    resolvedOptions: resolvedOptions,
    supportedLocalesOf: supportedLocalesOf
  }
}()
