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
