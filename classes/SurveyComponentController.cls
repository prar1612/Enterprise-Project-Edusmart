/*****************************************************************************************
	Class Name: SurveyComponentController
	Purpose: Controller for the SurveyComponentPage
	******************************************************************************************/
public class SurveyComponentController {
    public string message{get;set;}
    public Boolean isRetrieve{get;set;}
	
    /*****************************************************************************************
	Method Name: SendEmail
	Purpose: Method to send survey email to students
	******************************************************************************************/	
   public void SendEmail()
     {
         message='';
         isRetrieve=false;
        String subject = 'Student Satisfaction survey';
        String body = 'Hi,<br/>Here is a small survey on your experience at the university for this semester. Please complete the survey by visiting the below link:<br/>'+Label.Survey_Link+'<br/>Please complete it within the next 5 days. Your feedback will help us serve you better!<br/><br/>Note: Please do not reply to this email! <br/><br/>Thanks,<br/>Edusmart Admin';       
        // Create a master list to store the emails that we will send
        List<Messaging.SingleEmailMessage> masterListMails =  
        new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 

            // Set list of peoples who should recieve an email
            List<String> sendTo = new List<String>();
            sendTo.add('prarthana.hemanth@gmail.com');
            // sendTo.add('manasipai1986@gmail.com');
            email.setToAddresses(sendTo);
 
             email.setSenderDisplayName('Edusmart');
 
             // Sets the paramaters of the email
             email.setSubject( subject ); 
             email.setHTMLBody( body );
              masterListMails.add(email);
        /*for (Contact myContact : [SELECT ID, Email FROM Contact])
        {
           // Define the email
           Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 

            // Set list of peoples who should recieve an email
            List<String> sendTo = new List<String>();
            sendTo.add(myContact.Email);
            email.setToAddresses(sendTo);
 
             email.setSenderDisplayName('Official Nitish Account');
 
             // Sets the paramaters of the email
             email.setSubject( subject ); 
             email.setPlainTextBody( body );
 
             // Add your email address into the master list
             masterListMails.add(email);
         }*/
       // Sends mass emails
       Messaging.sendEmail(masterListMails);
       message = 'Survey email sent to all students!';
        
       
      }
      
	  /*****************************************************************************************
	Method Name: clearSurveyResults
	Purpose: Method to delete old survey results
	******************************************************************************************/	
      public void clearSurveyResults(){
           isRetrieve=false;
          message ='';
          list<SurveyMonkeyResp__c> responseList = new list<SurveyMonkeyResp__c>();
          responseList = [SELECT id from SurveyMonkeyResp__c];
          if(!responseList.isEmpty()) {
              database.delete(responseList);
          }
          message = 'Old survey data has been cleared.';
           
          
      }
      
	  /*****************************************************************************************
	Method Name: retrieveSurveyResults
	Purpose: Method to get survey results from Survey Monkey
	******************************************************************************************/	
      public void retrieveSurveyResults(){
         
          message = '';
          SurveyMonkeyOuth2 survCl = new SurveyMonkeyOuth2 ();
          survCl.getSurveyResopnse();
          message = 'Survey results retrieved! Please click the link and run the report to view the results.';
            isRetrieve=true;
      }
      
	  /*****************************************************************************************
	Method Name: showReport
	Purpose: Method to show the survey results report
	******************************************************************************************/	
      public PageReference showReport(){
          PageReference pf=new PageReference('/00O4T000000Yp7m');
          return pf;
          
      }
}