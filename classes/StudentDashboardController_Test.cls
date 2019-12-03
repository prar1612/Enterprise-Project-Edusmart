/*****************************************************************************************
	Class Name: StudentDashboardController_Test
	Purpose: Test class for StudentDashboardController
	******************************************************************************************/
@isTest(seeAllData=FALSE)
public class StudentDashboardController_Test {
    public static User u{get;set;}
    public static Student__c stud{get;set;}
    public static Teacher__c tch{get;set;}
    public static Course__c crs{get;set;}
    public static Course_Assignment__c ca{get;set;}
    public static Invoice__c inv{get;set;}
    public static Appointment__c app{get;set;}
    public static User admin{get;set;}
	
	/*****************************************************************************************
	Method Name: createData
	Purpose: Method to create test data
	******************************************************************************************/
    static void createData(){
        admin = DataFactory.createUser('System Administrator');
		u =   DataFactory.createUser('Student Profile');
        stud =  DataFactory.createStudent(u.Id); 
        tch = DataFactory.createTeacher();
        crs = DataFactory.createCourse(tch);
        ca = DataFactory.createCourseAssignment(crs,stud);
        inv =  DataFactory.createInvoice(stud);
        app = DataFactory.createAppointment(stud, tch);
    }
	
	/*****************************************************************************************
	Method Name: scenario1
	Purpose: Test method to test the functionality
	******************************************************************************************/
     static testMethod void scenario1(){
       createData();
         System.runAs(u){
     	StudentDashboardController st = new StudentDashboardController();
             test.startTest();

                 st.viewCourseDetails();
                 st.getCourses();
                 
                 st.getEnrolledCourses();
                 st.edit();
                 st.enroll();
                 st.closePopup();
                 st.saveCourses();
                 st.crsId = crs.Id;
                 st.removeCourse();
                 st.viewInvoice();
                
             	st.payFees();
               
                   //  st.appTemp= [SELECT ID,Name,Date__c,End_Time__c,Start_Time__c,Student__c,Teacher__c,Teacher__r.name,Teacher__r.Phone__c,Student__r.First_Name__c from Appointment__c where Id=:app.Id];

              //  st.sendSMS();
             test.stopTest();
         }
         
        
     }

}