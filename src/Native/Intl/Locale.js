//import Maybe //

var _thetalecrafter$elm_intl$Native_Intl_Locale = function () {

// this will create an early error if Intl is not supported
var checker = Intl.NumberFormat

function fromString (tag) {
  try {
    var supported = checker.supportedLocalesOf([ tag ]) // throws if the tag is invalid
    // use the canonicalized tag, if it is a supported language
    return _elm_lang$core$Maybe$Just(
      _thetalecrafter$elm_intl$Intl_Locale$Locale(supported[0] || tag)
    )
  } catch (e) {
    return _elm_lang$core$Maybe$Nothing
  }
}

return {
  fromString: fromString
}

}();
