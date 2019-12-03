/*****************************************************************************************
Class Name: AssignmentSubmissionController
Purpose: Controller for AssignmentSubmissionPage
******************************************************************************************/
public class AssignmentSubmissionController{
    public Id assnId{get;set;}
    public list<Submission__c> submissionList {get;set;}
    public set<Id> subIdSet{get;set;}
    public list<Attachment> docsList{get;set;}
    public Assignment__c assn{get;set;}
    public Id docId{get;set;}
	
	/*****************************************************************************************
	Method Name: AssignmentSubmissionController
	Purpose: Constructor method
	******************************************************************************************/	
    public AssignmentSubmissionController(){
        subIdSet = new set<Id>();
		//get the assignment from the URL Parameter
        assnId=apexpages.currentpage().getparameters().get('att');
        assn = [SELECT ID,Name from Assignment__c where ID=:assnId];
		//query submission for the assignment
        submissionList = [SELECT ID,Name,Assignment__c,Score__c,Student__c from Submission__c where Assignment__c =:assnId];
        if(!submissionList.isEmpty()){
            for(Submission__c sub: submissionList) {
                subIdSet.add(sub.Id);
            }
			//query the files attached to the submission record
            docsList = [SELECT ID,Name,ParentId from Attachment where ParentID IN:subIdSet];
        }
    }
	
	/*****************************************************************************************
	Method Name: viewSubmission
	Purpose: Method to redirect to the submission page
	******************************************************************************************/	
    public pageReference viewSubmission(){
        PageReference pf = new PageReference('/'+docId);
        
        return pf;
    }
}