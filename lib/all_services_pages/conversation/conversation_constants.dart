const socketURL = 'wss://api.dhruva.ai4bharat.org';
const ulcaBaseURL = 'https://dev-auth.ulcacontrib.org/ulca/apis';
const ulcaConfigReqURLPath = '/v0/model/getModelsPipeline';

const submitterToUse = 'AI4Bharat';
const isStreamingPreferred = true;

const taskTypeASR = {"taskType": "asr"};
const taskTypeNMT = {"taskType": "translation"};
const taskTypeTTS = {"taskType": "tts"};

const ulcaConfigRequestPayload = {
  "pipelineTasks": [],
  "pipelineRequestConfig": {"submitter": ""}
};

const asrComputePayload = {
  "serviceId": "",
  "taskType": "asr",
  "config": {
    "language": {"sourceLanguage": ""},
    "audioFormat": "wav",
    "samplingRate": 44100
  }
};

const trnaslationComputePayload = {
  "serviceId": "",
  "taskType": "translation",
  "config": {
    "language": {"sourceLanguage": "", "targetLanguage": ""}
  }
};
const ttsComputePayload = {
  "serviceId": "",
  "taskType": "tts",
  "config": {
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

const socketTaskSeq = [
  {
    "taskType": "asr",
    "config": {
      "language": {"sourceLanguage": ""},
      "samplingRate": 16000,
      // "audioFormat": "pcm",
      // "encoding": None,
      // "channel": "mono",
      // "bitsPerSample": "sixteen"
    }
  },
  {
    "taskType": "translation",
    "config": {
      "language": {"sourceLanguage": "", "targetLanguage": ""}
    }
  },
  {
    "taskType": "tts",
    "config": {
      "language": {"sourceLanguage": ""},
      "gender": ""
    }
  }
];
