/*****************************************************************************************
	Class Name: SMResponse
	Purpose: Class to get the survey response
	******************************************************************************************/
public class SMResponse {
public Integer per_page;
  public Integer total;
  public cls_data[] data;
  public Integer page;
  public cls_links links;

  class cls_data {
    public Integer total_time;
    public String href; 
    public cls_custom_variables custom_variables;
    public String ip_address; 
    public String id;
    public cls_logic_path logic_path;
    public String date_modified;
    public String response_status;
    public String custom_value; 
    public String analyze_url;
    public cls_pages[] pages;
    public cls_page_path[] page_path;
    public String recipient_id; 
    public String collector_id; 
    public String date_created; 
    public String survey_id;
    public String collection_mode; 
    public String edit_url; 
    public cls_metadata metadata;
  }

  class cls_custom_variables {}
  class cls_logic_path {}
  class cls_page_path {}
  class cls_metadata {}

  class cls_pages {
    public String id;
    public cls_questions[] questions;
  }

  class cls_questions {
    public String id;
    public cls_answers[] answers;
  }

  class cls_answers {
    public String choice_id;
  }

  class cls_links {
    public String self;
  }

  public static List<SurveyMonkeyResp__c> parse(String json) {
    SMResponse resp = (SMResponse) System.JSON.deserialize(json, SMResponse.class);
    List<SurveyMonkeyResp__c> smrList = new List<SurveyMonkeyResp__c>();
    for (cls_data c : resp.data) {
      System.debug('Analyze url-->'+c.analyze_url);
      for (cls_pages pList : c.pages) {  //Pages are captured here
        for (cls_questions q : pList.questions) { //Questions here
          for (cls_answers a : q.answers) { //Answerd here
            if (q.Id != null && a.choice_Id != null) {
              SurveyMonkeyResp__c smr = new SurveyMonkeyResp__c();
              smr.question_Id__c = Decimal.valueOf(q.Id);
              smr.Choice_Id__c = Decimal.valueOf(a.choice_Id);
              smr.SurveyID__c = Decimal.valueOf(c.survey_id);
              String respId = c.analyze_url;
              if (respId != null && respId.contains('?respondent_id=')) {
                smr.RespondentID__c = Decimal.valueOf(respId.substring(
                  respId.lastIndexOfIgnoreCase('?respondent_id')+15));
              }
              smrList.add(smr);
            }
          }
        }
      }
    }
    return smrList;
  }
}