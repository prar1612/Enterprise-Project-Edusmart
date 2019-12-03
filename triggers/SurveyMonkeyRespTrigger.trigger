trigger SurveyMonkeyRespTrigger on SurveyMonkeyResp__c (before insert) {
if(Trigger.isBefore) {
    if (Trigger.isInsert) {
      SurveyMonkeyRespHandler.beforeInsert(Trigger.new);
    }
  }
}