import 'enum_global.dart';

const hiveDBName = 'db_bhashini';
const appName = 'Bhashini';
const screenUtilWidth = 540.0;
const screenUtilHeight = 1200.0;

const languageMap = {
  'language_codes': [
    {'language_name': 'Urdu', 'language_code': 'ur'},
    {'language_name': 'Oria', 'language_code': 'or'},
    {'language_name': 'Bodo', 'language_code': 'brx'},
    {'language_name': 'Tamil', 'language_code': 'ta'},
    {'language_name': 'Hindi', 'language_code': 'hi'},
    {'language_name': 'Bangla', 'language_code': 'bn'},
    {'language_name': 'Dogri', 'language_code': 'doi'},
    {'language_name': 'Telugu', 'language_code': 'te'},
    {'language_name': 'Nepali', 'language_code': 'ne'},
    {'language_name': 'English', 'language_code': 'en'},
    {'language_name': 'Punjabi', 'language_code': 'pa'},
    {'language_name': 'Sinhala', 'language_code': 'si'},
    {'language_name': 'Marathi', 'language_code': 'mr'},
    {'language_name': 'Kannada', 'language_code': 'kn'},
    {'language_name': 'Sanskrit', 'language_code': 'sa'},
    {'language_name': 'Assamese', 'language_code': 'as'},
    {'language_name': 'Gujarati', 'language_code': 'gu'},
    {'language_name': 'Maithili', 'language_code': 'mai'},
    {'language_name': 'Bhojpuri', 'language_code': 'bho'},
    {'language_name': 'Malayalam', 'language_code': 'ml'},
    {'language_name': 'Manipuri', 'language_code': 'mni'},
    {'language_name': 'Rajasthani', 'language_code': 'raj'}
  ]
};

class GlobalAppConstants {
  static String getLanguageCodeOrName({required String value, required returnWhat}) {
    // If Language Code is to be returned that means the value received is a language name
    try {
      if (returnWhat == LANGUAGE_MAP.languageCode) {
        var returningLangPair = languageMap['language_codes']!
            .firstWhere((eachLanguageCodeNamePair) => eachLanguageCodeNamePair['language_name']!.toLowerCase() == value.toLowerCase());
        return returningLangPair['language_code'] ?? 'No Language Code Found';
      }

      var returningLangPair = languageMap['language_codes']!
          .firstWhere((eachLanguageCodeNamePair) => eachLanguageCodeNamePair['language_code']!.toLowerCase() == value.toLowerCase());
      return returningLangPair['language_name'] ?? 'No Language Name Found';
    } catch (e) {
      return 'No Return Value Found';
    }
  }

  /*Used for deep copying original map to a new map. If not, dart will shallow copy where Objects are passed by referenced
  which will change the original value even if changes are made to the copied value.
  */
  static Map<String, dynamic> deepCopyMap(Map<String, dynamic> original) {
    Map<String, dynamic> copy = {};
    original.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        copy[key] = deepCopyMap(value);
      } else if (value is List) {
        copy[key] = value.map((e) => e is Map<String, dynamic> ? deepCopyMap(e) : e).toList();
      } else {
        copy[key] = value;
      }
    });
    return copy;
  }
}
