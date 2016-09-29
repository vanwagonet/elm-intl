//import Native.List //
//import Intl.Locale //

var _thetalecrafter$elm_intl$Native_Intl_Collator = function () {
  
// this will create an early error if Intl is not supported
var Collator = Intl.Collator

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
  var array = _elm_lang$core$Native_List.toArray(list).map(function (locale) {
    return locale._0
  })
  var supported = Collator.supportedLocalesOf(array).map(
    _thetalecrafter$elm_intl$Intl_Locale$Locale
  )
  return _elm_lang$core$Native_List.fromArray(supported)
}

return {
  fromLocale: fromLocale,
  fromOptions: fromOptions,
  compare: F3(compare),
  resolvedOptions: resolvedOptions,
  supportedLocalesOf: supportedLocalesOf
}

}();