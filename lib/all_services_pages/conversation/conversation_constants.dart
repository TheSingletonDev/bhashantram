const ulcaBaseURL = 'https://dev-auth.ulcacontrib.org/ulca/apis';
const ulcaConfigReqURLPath = '/v0/model/getModelsPipeline';

const submitterToUse = 'AI4Bharat';

const taskTypeASR = {"taskType": "asr"};
const taskTypeNMT = {"taskType": "translation"};
const taskTypeTTS = {"taskType": "tts"};

const ulcaConfigRequestPayload = {
  "pipelineTasks": [],
  "pipelineRequestConfig": {"submitter": ""}
};
