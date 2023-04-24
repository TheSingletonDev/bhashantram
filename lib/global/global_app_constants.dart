import 'enum_global.dart';

const hiveDBName = 'db_bhashini';
const appName = 'Bhashini';
const screenUtilWidth = 540.0;
const screenUtilHeight = 1200.0;

const socketURL = 'wss://api.dhruva.ai4bharat.org';
const ulcaBaseURL = 'https://meity-auth.ulcacontrib.org/ulca/apis';
const ulcaConfigReqURLPath = '/v0/model/getModelsPipeline';

const pipelineIdMeitY = '64392f96daac500b55c543cd';
const pipelineIdAI4B = '643930aa521a4b1ba0f4c41d';
const isStreamingPreferred = false;

const taskTypeASR = {"taskType": "asr"};
const taskTypeNMT = {"taskType": "translation"};
const taskTypeTTS = {"taskType": "tts"};

const ulcaConfigRequestPayload = {
  "pipelineTasks": [],
  "pipelineRequestConfig": {"pipelineId": ""}
};

const asrComputePayload = {
  "taskType": "asr",
  "config": {
    "serviceId": "",
    "language": {"sourceLanguage": ""},
    "audioFormat": "wav",
    "samplingRate": 16000
  }
};

const trnaslationComputePayload = {
  "taskType": "translation",
  "config": {
    "serviceId": "",
    "language": {"sourceLanguage": "", "targetLanguage": ""}
  }
};
const ttsComputePayload = {
  "taskType": "tts",
  "config": {
    "serviceId": "",
    "language": {"sourceLanguage": ""},
    "gender": ""
  }
};

const asrComputeInputData = {
  "audio": [
    {"audioContent": ""}
  ]
};

const s2sComputePayload = {"pipelineTasks": [], "inputData": {}};

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
        var returningLangPair = languageMap['language_codes']!.firstWhere((eachLanguageCodeNamePair) => eachLanguageCodeNamePair['language_name']!.toLowerCase() == value.toLowerCase());
        return returningLangPair['language_code'] ?? 'No Language Code Found';
      }

      var returningLangPair = languageMap['language_codes']!.firstWhere((eachLanguageCodeNamePair) => eachLanguageCodeNamePair['language_code']!.toLowerCase() == value.toLowerCase());
      return returningLangPair['language_name'] ?? 'No Language Name Found';
    } catch (e) {
      return 'No Return Value Found';
    }
  }

  /*Used for deep copying original map to a new map. If not, dart will shallow copy where Objects are passed by referenced
  which will change the original value even if changes are made to the copied value.
  */
  static Map<dynamic, dynamic> deepCopyMap(Map<dynamic, dynamic> original) {
    Map<dynamic, dynamic> copy = {};
    original.forEach((key, value) {
      if (value is Map<dynamic, dynamic>) {
        copy[key] = deepCopyMap(value);
      } else if (value is List) {
        copy[key] = value.map((e) => e is Map<dynamic, dynamic> ? deepCopyMap(e) : e).toList();
      } else {
        copy[key] = value;
      }
    });
    return copy;
  }
}
