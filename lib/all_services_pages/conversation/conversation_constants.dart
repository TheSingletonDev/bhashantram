const submitterToUse = 'AI4Bharat';

const taskTypeASR = {"taskType": "asr"};
const taskTypeNMT = {"taskType": "translation"};
const taskTypeTTS = {"taskType": "tts"};

const ulcaConfigRequestPayload = {
  "pipelineTasks": [],
  "pipelineRequestConfig": {"submitter": ""}
};

const tempULCAConfigResponse = {
  "languages": [
    {
      "sourceLanguage": "en",
      "targetLanguageList": ["hi", "te"]
    },
    {
      "sourceLanguage": "hi",
      "targetLanguageList": ["mr", "te"]
    }
  ],
  "pipelineInferenceAPIEndPoint": {
    "callbackUrl": "URL goes here",
    "inferenceApiKey": {"name": "Auth", "value": "23432egtre6y5"}
  },
  "pipelineResponseConfig": [
    {
      "tasktype": "asr",
      "config": [
        {
          "serviceId": "",
          "language": {"sourceLanguage": "en"}
        },
        {
          "serviceId": "",
          "language": {"sourceLanguage": "hi"}
        }
      ]
    },
    {
      "tasktype": "translation",
      "config": [
        {
          "serviceId": "",
          "language": {"sourceLanguage": "en", "targetLanguage": "hi"}
        },
        {
          "serviceId": "",
          "language": {"sourceLanguage": "en", "targetLanguage": "te"}
        },
        {
          "serviceId": "",
          "language": {"sourceLanguage": "hi", "targetLanguage": "mr"}
        },
        {
          "serviceId": "",
          "language": {"sourceLanguage": "hi", "targetLanguage": "te"}
        }
      ]
    },
    {
      "tasktype": "tts",
      "config": [
        {
          "serviceId": "",
          "language": {"sourceLanguage": "te"}
        },
        {
          "serviceId": "",
          "language": {"sourceLanguage": "hi"}
        },
        {
          "serviceId": "",
          "language": {"sourceLanguage": "hi"}
        },
        {
          "serviceId": "",
          "language": {"sourceLanguage": "mr"}
        }
      ]
    }
  ]
};
