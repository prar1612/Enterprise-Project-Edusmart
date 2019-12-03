/*****************************************************************************************
	Class Name: TeacherDashboardController_Test
	Purpose:Test class for TeacherDashboardController
	******************************************************************************************/
@isTest
public class TeacherDashboardController_Test {
     public static User u{get;set;}
    public static Teacher__c tc{get;set;}
    public static Appointment__c app{get;set;}
    public static Student__c stud{get;set;}
	
	/*****************************************************************************************
	Method Name: createData
	Purpose:Method to create test data
	******************************************************************************************/
	static void createData(){
        u =   DataFactory.createUser('Teacher Profile');
        tc = DataFactory.createTeacher();
        stud = DataFactory.createStudent(u.Id);
        app = DataFactory.createAppointment(stud,tc);
        tc.User__c =u.id;
        update tc;
    }
	
	/*****************************************************************************************
	Method Name: scenario1
	Purpose:Method to test the functionality
	******************************************************************************************/
     static testMethod void scenario1(){
         createData();
          System.runAs(u){
              TeacherDashboardController tch = new TeacherDashboardController();
              tch.viewCourseDetails();
              tch.appId = app.Id;
              
              tch.cancelAppointment();
              
          	
          }
     }
}