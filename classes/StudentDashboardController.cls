/*****************************************************************************************
	Class Name: StudentDashboardController
	Purpose: Controller for StudentDashboard Page
	******************************************************************************************/
public class StudentDashboardController{
    public String accountId {get;set;}
    public String type {get;set;}
    public Student__c stud{get;set;}
    public list <Course_Assignment__c> course_assignment{get;set;}
    public boolean showpopup {get;set;}
    public list <CourseWrapper>courseList{get;set;}
    public boolean showCourses {get;set;}
    public String UserId {get;set;}
    public Id crsId{get;set;}
    public list<Appointment__c> appList{get;set;}
    public Id appId{get;set;}
    public Decimal dueAmount{get;set;}
    public list<Invoice__c> invoiceList{get;set;}
    public Id invId{get;set;}
    public Appointment__c appTemp{get;set;}
	
	/*****************************************************************************************
	Method Name: StudentDashboardController
	Purpose: Constructor method
	******************************************************************************************/
    public StudentDashboardController() {   
		showCourses=true;
		accountId = Apexpages.currentpage().getparameters().get('id'); 
		type = Apexpages.currentpage().getparameters().get('Type'); 
		UserId = UserInfo.getUserId();
        stud = [SELECT ID,First_Name__c,Last_Name__c,Address__c,Email__c,GRE_Score__c,Major__c,Phone__c,User__c,Semester__c FROM Student__c where User__c=:userId];
        course_assignment = [SELECT ID,Student__c,Course__c from Course_Assignment__c where Student__c =:stud.Id];
        Date tdy = Date.Today();
		appList = [SELECT ID,Name,Date__c,End_Time__c,Start_Time__c,Student__c,Teacher__c,Teacher__r.name,Teacher__r.Phone__c,Student__r.First_Name__c from Appointment__c where Student__c=:stud.id and Date__c >:tdy];
		invoiceList = [SELECT ID,Name,Amount__c,Student__c,Transaction_Id__c from Invoice__c where Student__c =:stud.id];
		Decimal paidAmount = 0;
		if(!invoiceList.isEmpty()) {
			for(Invoice__c inv:invoiceList){
				paidAmount+=inv.amount__c;
			}
		}
		dueAmount = (course_assignment .size() *2000)-paidAmount ;
	}
	
	/*****************************************************************************************
	Method Name: viewCourseDetails
	Purpose: Method to navigate to selected course
	******************************************************************************************/
   public PageReference viewCourseDetails() {
       PageReference pf = new PageReference('/apex/CourseDetails?att='+crsId);
        return pf;
    }
	
	/*****************************************************************************************
	Method Name: viewInvoice
	Purpose: Method to navigate to selected invoice
	******************************************************************************************/
	public PageReference viewInvoice(){
	  PageReference pf = new PageReference('/'+invId);
	  return pf;
	}
	
	/*****************************************************************************************
	Method Name: getCourses
	Purpose: Method to get list of courses
	******************************************************************************************/
	public List<courseWrapper> getCourses() {
      set<Id>courseIdSet=new set<Id>();
      if(course_assignment.size() > 0) {
          for(Course_assignment__c ca : course_assignment){
              courseIdSet.add(ca.course__c);
          }
      }
		if(courseList == null) {
			courseList = new List<CourseWrapper>();
			for(Course__c c: [select Id, Name,Course_Name__c, Major__c,Semester__c from Course__c where Major__c=:stud.Major__c and Semester__c=:stud.semester__c and id not in:courseIdset]) {
				// As each contact is processed we create a new cContact object and add it to the contactList
				courseList.add(new courseWrapper(c));
			}
		}
		return courseList;
	}
	
	/*****************************************************************************************
	Method Name: removeCourse
	Purpose: Method to remove a course
	******************************************************************************************/
	public pageReference removeCourse(){
	Course_assignment__c CrsToBeDeleted;
	list<Course_assignment__c> newList = new list<Course_assignment__c>();
    for(Course_assignment__c ca:course_assignment){
        if(ca.course__c == crsId) {
            CrsToBeDeleted = ca;
        }
        else{
            newList.add(ca);
        }
    }
    delete CrsToBeDeleted;
    course_assignment = newList;
     Decimal paidAmount = 0;
    if(!invoiceList.isEmpty()) {
        for(Invoice__c inv:invoiceList){
            paidAmount+=inv.amount__c;
        }
    }
    dueAmount = (course_assignment.size() *2000)-paidAmount ;
    return null;
    
}

	/*****************************************************************************************
	Method Name: cancelAppointment
	Purpose: Method to cancel an appointment
	******************************************************************************************/
	public void cancelAppointment(){
		list<Appointment__c> newAppList = new list<Appointment__c>();
		Appointment__c appToBeDeleted;
		for(Appointment__c app: appList){
			if(app.Id == appId) {
				appToBeDeleted = app;
				
			}
			else{
				newAppList.add(app);
			}
		}
		appTemp =new Appointment__c();
		appTemp = appToBeDeleted;
		database.delete(appToBeDeleted);
		appList = newAppList;
	}
	/*****************************************************************************************
	Method Name: sendSMS
	Purpose: Method to send cancellation SMS
	******************************************************************************************/
	public void sendSMS(){
      String account = Label.Twilio_Account_ID;
        String token = Label.Twilio_Token;
        TwilioRestClient client = new TwilioRestClient(account, token);
        
        Map<String,String> params = new Map<String,String> {
                'To'   => appTemp.teacher__r.phone__c,
                'From' => '+12566079818',
                'Body' => 'Hi,'+appTemp.teacher__r.Name+' your appointment with '+appTemp.student__r.first_name__c+' on '+appTemp.Date__c+' at '+appTemp.Start_Time__c+' is cancelled. '
            };
        TwilioSMS sms = client.getAccount().getSMSMessages().create(params);
	}
	
	/*****************************************************************************************
	Method Name: getEnrolledCourses
	Purpose: Method to get enrolled courses
	******************************************************************************************/
	public list<Course__c> getEnrolledCourses(){
	set<Id>courseIdSet=new set<Id>();
    for(course_assignment__c ca: course_assignment){
        courseIdSet.add(ca.course__c);
    }
    list<Course__c> cr = [SELECT ID,Name,Course_Name__c from Course__c where Id in:courseIdSet ];
    Decimal paidAmount = 0;
    if(!invoiceList.isEmpty()) {
        for(Invoice__c inv:invoiceList){
            paidAmount+=inv.amount__c;
        }
    }
    dueAmount = (cr.size() *2000)-paidAmount ;
    return cr;
   
    
	}
	
	/*****************************************************************************************
	Method Name: payFees
	Purpose: Method to pay tuition fees
	******************************************************************************************/	
	public pageReference payFees(){
	  PageReference pf = new PageReference('/apex/FeePayment?att='+stud.Id+','+dueAmount);
	  return pf;
	}
	
	/*****************************************************************************************
	Method Name: enroll
	Purpose: Method to show course enrollment pop up
	******************************************************************************************/	
	public void enroll(){
	  showpopup=true;
	}
	
	/*****************************************************************************************
	Method Name: closePopup
	Purpose: Method to close course enrollment pop up
	******************************************************************************************/	
	public void closePopup(){
	  showpopup=false;
	}
	/*****************************************************************************************
	Method Name: saveCourses
	Purpose: Method to savecourses selected
	******************************************************************************************/	
	public pageReference saveCourses(){
      String message = '';
      List<Course_Assignment__c> caList = new list<Course_Assignment__c>();
       List<Course__c> selectedCourses = new List<Course__c>();

    //We will cycle through our list of cContacts and will check to see if the selected property is set to true, if it is we add the Contact to the selectedContacts list
    for(CourseWrapper cCon: getCourses()) {
        if(cCon.selected == true) {
            selectedCourses.add(cCon.crs);
        }
    }
    if(course_assignment.size() + selectedCourses.size() > 3){
        message = 'You can only select 3 courses per semester. Please enure not to select more than 3 courses.';
         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,message));
         return null;
    }
    else {
        for(Course__c c: selectedCourses){
            Course_Assignment__c ca = new Course_Assignment__c(Student__c = stud.Id, Course__c = c.id);
            caList.add(ca);
        }
        insert caList;
        //course_assignment.clear();
        if(course_assignment.size() == 0){
            course_assignment = caList;
        }
        else{
            course_assignment.addAll(caList);
        }
        showpopup = false;
        courseList=null; // we need this line if we performed a write operation  because getContacts gets a fresh list now
        return null;
    }
    
  }
  
  /*****************************************************************************************
	Class Name: courseWrapper
	Purpose: Wrapper class to show course list
	******************************************************************************************/	
  public class courseWrapper {
    public Course__c crs {get; set;}
    public Boolean selected {get; set;}

    //This is the contructor method. When we create a new cContact object we pass a Contact that is set to the con property. We also set the selected value to false
	/*****************************************************************************************
	Method Name: courseWrapper
	Purpose: Wrapper contructor method
	******************************************************************************************/	
    public courseWrapper(Course__c c) {
        crs = c;
        selected = false;
    }
}

}