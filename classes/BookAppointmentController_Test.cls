/*****************************************************************************************
	Class Name: BookAppointmentController_Test
	Purpose: Test class for BookAppointmentController
	******************************************************************************************/
@isTest
public class BookAppointmentController_Test {
    public static User u{get;set;}
    public static Student__c stud{get;set;}
    public static Teacher__c tch{get;set;}
	
	/*****************************************************************************************
	Method Name: createData
	Purpose: Method to create data for testing
	******************************************************************************************/
     static void createData(){
         u = Datafactory.createUser('Student Profile');
         stud = DataFactory.createStudent(u.Id);
         tch = Datafactory.createTeacher();
     }
	 
	 /*****************************************************************************************
	Method Name: scenario1
	Purpose: Method to test the functionality
	******************************************************************************************/
	static testMethod void scenario1(){
       createData();
     System.runAs(u){
         BookAppointmentController bookApp = new BookAppointmentController();
         bookApp.searchForProfessor();
         bookApp.tchrId = tch.Id;
         bookApp.appDate = date.today()+10;
         bookApp.bookAnAppointment();
         bookApp.slotSet = new set<Time>();
         bookApp.closePopup();
         bookApp.showAvailableSlots();
     }
 }
}