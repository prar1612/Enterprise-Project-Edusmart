/*****************************************************************************************
	Class Name: TeacherDashboardController
	Purpose:Controller for the Teacher Dashboard Page
	******************************************************************************************/
public class TeacherDashboardController {    
    public Teacher__c tchr {get;set;}
    public Id userId{get;set;}
    public list<Course__c> courseList{get;set;}
    public Id crsId{get;set;}
    public List<Appointment__c>appList{get;set;}
    public Id appId{get;set;}
    public Appointment__c appTemp{get;set;}
	
	/*****************************************************************************************
	Method Name: TeacherDashboardController
	Purpose:Constructor method
	******************************************************************************************/
    public TeacherDashboardController(){
          UserId = UserInfo.getUserId();
          tchr = [SELECT ID,Name,Phone__c,Email__c,User__c from Teacher__c where User__c=:UserId];
          courseList = [SELECT ID,Name,Major__c,Course_Name__c,Days_of_the_week__c,Semester__c,Teacher__c,Timings__c,Venue__c FROM Course__c where Teacher__c=:tchr.id];
         Date tdy = Date.Today();
         appList = [SELECT ID,Name,Date__c,End_Time__c,Start_Time__c,Student__c,Teacher__c,teacher__r.name,Student__r.first_name__c,student__r.last_name__c,student__r.phone__c from Appointment__c where Teacher__c=:tchr.id and Date__c >:tdy];
    }
	
	/*****************************************************************************************
	Method Name: viewCourseDetails
	Purpose: Method to view details of selected course
	******************************************************************************************/
    public pageReference viewCourseDetails(){
         PageReference pf = new PageReference('/apex/CourseDetailsTeacherView?att='+crsId);
        return pf;
    }
	
	/*****************************************************************************************
	Method Name: cancelAppointment
	Purpose: Method to cancel an appointment
	******************************************************************************************/
    public void cancelAppointment(){
        list<Appointment__c> newAppList = new list<Appointment__c>();
    Appointment__c appToBeDeleted = null;
    for(Appointment__c app: appList){
        if(app.Id == appId) {
            appToBeDeleted = app;
             
        }
        else{
            newAppList.add(app);
        }
    }
    system.debug('appToBeDeleted...'+appToBeDeleted);
        if(appToBeDeleted != null){
               appTemp =new Appointment__c();
    appTemp = appToBeDeleted;
  
            database.delete(appToBeDeleted);
        }
    appList = newAppList;
    }
	
	/*****************************************************************************************
	Method Name: sendSMS
	Purpose: Method to send an SMS after the appointment is cancelled
	******************************************************************************************/
    public void sendSMS(){
      String account = Label.Twilio_Account_ID;
        String token = Label.Twilio_Token;    
        TwilioRestClient client = new TwilioRestClient(account, token);
        
        Map<String,String> params = new Map<String,String> {
                'To'   => appTemp.student__r.phone__c,
                'From' => '+12566079818',
                'Body' => 'Hi,'+appTemp.student__r.First_Name__c+' your appointment with Professor '+appTemp.teacher__r.name+ ' on '+appTemp.Date__c+' at '+appTemp.Start_Time__c+' has been cancelled. '
            };
        TwilioSMS sms = client.getAccount().getSMSMessages().create(params);
}
}