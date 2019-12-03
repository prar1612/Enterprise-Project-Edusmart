/*****************************************************************************************
	Class Name: SurveyMonkeyOuth2
	Purpose:Class for SurveyMonkey Authorization
	******************************************************************************************/
public class SurveyMonkeyOuth2 {
public String surveyData {set; get;}
    public String errorMessage {set; get;}
    
	/*****************************************************************************************
	Method Name: getSurveyResopnse
	PurposeMethod to get the response from survey monkey
	******************************************************************************************/
    public void getSurveyResopnse() {
        try{
            HttpRequest objReq = new HttpRequest();
            //Move to Named credentials
            objReq.setEndpoint('https://api.surveymonkey.com/v3/surveys/272400375/responses/bulk');
            objReq.setMethod('GET');
            objReq.setHeader('Authorization', 'Bearer ' + 'r0s9r6NRM1l6Hl6jTkDPwD1ERtmv2PQEc8R66iG1BZSy2avvZH2pOgMM4VhZT84AJcGPSsB7CHKuM-DpeO3cCiDh4POM9oslhDnpjJj7RMwrYQZF6MWRCoKEsr0VaOUA');
            Http objHttp = new Http();
            HTTPResponse objRes = objHttp.send(objReq);
            System.debug('Response data'+ objRes.getBody());
            if(!String.isBlank(objRes.getBody())) {
                List<SurveyMonkeyResp__c> smrList = SMResponse.parse(objRes.getBody());
                insert smrList;
            }
         } catch(Exception ex) {  
            errorMessage = ex.getMessage();
            System.debug('Exception :' + ex.getMessage());
         }
    }
    
	/*****************************************************************************************
	Method Name: getSurveyDetails
	Purpose: Method to get the survey details
	******************************************************************************************/
     public void getSurveyDetails() {
        try{
            HttpRequest objReq = new HttpRequest();
            objReq.setEndpoint('https://api.surveymonkey.com/v3/surveys/272400375/details');
            objReq.setMethod('GET');
            objReq.setHeader('Authorization', 'Bearer ' + 'r0s9r6NRM1l6Hl6jTkDPwD1ERtmv2PQEc8R66iG1BZSy2avvZH2pOgMM4VhZT84AJcGPSsB7CHKuM-DpeO3cCiDh4POM9oslhDnpjJj7RMwrYQZF6MWRCoKEsr0VaOUA');
            Http objHttp = new Http();
            HTTPResponse objRes = objHttp.send(objReq);
            surveyData = objRes.getBody();
            if(String.isBlank(surveyData)){
                surveyData = objRes.toString();
            }
            
            System.debug('----response :'+ surveyData);
         }
         catch(Exception ex)
         {  errorMessage = ex.getMessage();
            System.debug('Exception :' + ex.getMessage());
         }
   
 }
}