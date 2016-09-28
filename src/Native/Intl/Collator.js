//import Native.List //

var _thetalecrafter$elm_intl$_Native_Intl_Collator = function () {

var Collator = Intl.Collator

var usageToUnion = {
  search: { ctor: 'Search' },
  sort: { ctor: 'Sort' }
}

var usageFromUnionCtor = {
  Search: 'search',
  Sort: 'sort'
}

var sensitivityToUnion = {
  base: { ctor: 'Base' },
  accent: { ctor: 'Accent' },
  case: { ctor: 'Case' },
  variant: { ctor: 'Variant' }
}

var sensitivityFromUnionCtor = {
  Base: 'base',
  Accent: 'accent',
  Case: 'case',
  Variant: 'variant'
}

var caseFirstToUnion = {
  upper: { ctor: 'Upper' },
  lower: { ctor: 'Lower' },
  false: { ctor: 'Default' }
}

var caseFirstFromUnionCtor = {
  Upper: 'upper',
  Lower: 'lower',
  Default: 'false'
}

function fromLocale (locale) {
  return new Collator(locale)
}

function fromOptions (record) {
  var locale = record.locale
  var options = {
    usage: usageFromUnionCtor[record.usage.ctor],
    sensitivity: sensitivityFromUnionCtor[record.sensitivity.ctor],
    ignorePunctuation: record.ignorePunctuation,
    numeric: record.numeric,
    caseFirst: caseFirstFromUnionCtor[record.caseFirst.ctor]
  }
  return new Collator(locale, options)
}

function compare (string1, string2, collator) {
  var value = collator.compare(string1, string2)
  return { ctor: value === 0 ? 'EQ' : value < 0 ? 'LT' : 'GT' }
}

function resolvedOptions (collator) {
  var options = collator.resolvedOptions()
  return {
    locale: options.locale,
    usage: usageToUnion[options.usage],
    sensitivity: sensitivityToUnion[options.sensitivity],
    ignorePunctuation: record.ignorePunctuation,
    numeric: record.numeric,
    caseFirst: caseFirstToUnion[record.caseFirst.ctor]
  }
}

function supportedLocalesOf (list) {
  var array = _elm_lang$core$Native_List.toArray(list)
  var supported = Collator.supportedLocalesOf(array)
  return _elm_lang$core$Native_List.fromArray(supported)
}

return {
  fromLocale: fromLocale,
  fromOptions: fromOptions,
  compare: F3(compare),
  resolvedOptions: resolvedOptions,
  supportedLocalesOf: supportedLocalesOf
}

}()