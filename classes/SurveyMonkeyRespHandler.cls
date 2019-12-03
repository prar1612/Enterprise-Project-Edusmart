/*****************************************************************************************
	Class Name: SurveyMonkeyRespHandler
	Purpose:Handler class for the SurveyMonkeyResponseTrigger
	******************************************************************************************/
public with sharing class SurveyMonkeyRespHandler {
	/*****************************************************************************************
	Method Name: beforeInsert
	Purpose: Before insert trigger method
	******************************************************************************************/
	public static void beforeInsert(List<SurveyMonkeyResp__c> newLst) {
        Set<Decimal> allQIds = new Set<Decimal>();
        Set<Decimal> allAIds = new Set<Decimal>();
        Map<Decimal, Id> QMap = new Map<Decimal, Id>();
        Map<Decimal, Id> AMap = new Map<Decimal, Id>();
        for (SurveyMonkeyResp__c smr : newLst) {
            allQIds.add(smr.question_Id__c);
            allAIds.add(smr.Choice_Id__c);
        }
        for (SM_Answer__c a :
            [select Id, Answer_Id__c from SM_Answer__c where Answer_Id__c in :allAIds]) {
            
            AMap.put(a.Answer_Id__c, a.Id);
        }
        for (SM_Question__c q : 
            [select Id, Question_Id__c from SM_Question__c where question_Id__c in :allQIds]) {

            QMap.put(q.Question_Id__c, q.Id);    
        }
        for (SurveyMonkeyResp__c smr : newLst) {
            smr.SM_Answer__c = AMap.get(smr.Choice_Id__c);
            smr.SM_Question__c = QMap.get(smr.question_Id__c);
        }
    } 
}