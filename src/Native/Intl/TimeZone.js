// import Maybe //

/* global
  _elm_lang$core$Maybe$Just
  _elm_lang$core$Maybe$Nothing
  _thetalecrafter$elm_intl$Intl_TimeZone$TimeZone
*/
/* eslint-disable camelcase */

// eslint-disable-next-line
var _thetalecrafter$elm_intl$Native_Intl_TimeZone = function () {
  // this will create an early error if Intl is not supported
  var DateTimeFormat = Intl.DateTimeFormat

  function fromIANATimeZoneName (name) {
    try {
      var tz = DateTimeFormat(undefined, {
        timeZone: name
      }).resolvedOptions().timeZone
      return _elm_lang$core$Maybe$Just(
        _thetalecrafter$elm_intl$Intl_TimeZone$TimeZone(tz)
      )
    } catch (e) {
      return _elm_lang$core$Maybe$Nothing
    }
  }

  return {
    fromIANATimeZoneName: fromIANATimeZoneName
  }
}()
