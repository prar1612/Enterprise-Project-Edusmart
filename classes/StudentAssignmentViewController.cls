/*****************************************************************************************
	Class Name: StudentAssignmentViewController
	Purpose: Controller for StudentAssignmentView Page
	******************************************************************************************/
public class StudentAssignmentViewController {
   public Id asnId{get;set;}
    public Assignment__c asn{get;set;}
    public Id userId{get;set;}
    public Student__c stud{get;set;}
    public attachment objattachment{get;set;}
    public list<Submission__c> subList{get;set;}
    public Submission__c sub{get;set;}
    public Submission__c newSub{get;set;}
    public Attachment attch{get;set;}
    public Id subId{get;set;}
	
	/*****************************************************************************************
	Method Name: StudentAssignmentViewController
	Purpose: Constructor method
	******************************************************************************************/
    public StudentAssignmentViewController (){
     objAttachment = new attachment();
        userId = UserInfo.getUserId();
        stud = [SELECT ID,Name, First_Name__c,Last_Name__c,User__c from Student__C where user__C=:userId];
        asnId=apexpages.currentpage().getparameters().get('att');
        asn= [SELECT ID,Name,Course__c,Due_Date__c,Questions__c,Total_Points__c from Assignment__c where Id=:apexpages.currentpage().getparameters().get('att')];
        System.debug('1..'+asnId+'...'+stud.Id);
        subList = [SELECT ID,Name,Assignment__c,Student__c, (SELECT Id, Name FROM Attachments)
					from Submission__c where Assignment__c =:asnId AND student__c=:stud.Id];
		if(!subList.isEmpty()){
			sub = subList[0];
		}
    }
	
	/*****************************************************************************************
	Method Name: viewSubmission
	Purpose: Mthod to redirect to submission page
	******************************************************************************************/
    public pageReference viewSubmission(){
         pagereference pr = new pagereference('/' + subId);
        return pr;
    }
	
	/*****************************************************************************************
	Method Name: saveAssignment
	Purpose: Mthod to save assignment 
	******************************************************************************************/
    public pageReference saveAssignment(){
    if(subId == '' || subId ==NULL) { 
        newSub = new submission__c(Assignment__c = asn.Id,Student__c=stud.Id);
        insert newSub;
     }
     else {
         newSub = sub;
     }  
        objAttachment.ParentId = newSub.Id;
        insert objattachment;
           pagereference pr = new pagereference('/' + newSub.Id);
        return pr;
        
    }
}