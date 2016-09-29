// import Maybe //

/* global
  _elm_lang$core$Maybe$Just
  _thetalecrafter$elm_intl$Intl_Locale$Locale
  _elm_lang$core$Maybe$Nothing
*/
/* eslint-disable camelcase */

// eslint-disable-next-line
var _thetalecrafter$elm_intl$Native_Intl_Locale = function () {
  // this will create an early error if Intl is not supported
  var checker = Intl.NumberFormat

  function normalize (tag) {
    var parts = tag.toLowerCase().split('-')
    var index = 0
    var canHaveExtLang = index < parts.length && parts[index].length <= 3
    if (canHaveExtLang) {
      while (++index < parts.length && parts[index].length === 3);
    }
    var isScript = index < parts.length && parts[index].length === 4
    if (isScript) {
      parts[index] = parts[index][0].toUpperCase() + parts[index].slice(1)
      ++index
    }
    var isRegion = index < parts.length && parts[index].length === 2
    if (isRegion) {
      parts[index] = parts[index].toUpperCase()
    }
    return parts.join('-')
  }

  function fromString (tag) {
    try {
      checker.supportedLocalesOf([ tag ]) // throws if the tag is invalid
      // use the normalized tag, (doesn't do canonicalization like ji -> yi)
      return _elm_lang$core$Maybe$Just(
        _thetalecrafter$elm_intl$Intl_Locale$Locale(normalize(tag))
      )
    } catch (e) {
      return _elm_lang$core$Maybe$Nothing
    }
  }

  return {
    fromString: fromString
  }
}()
