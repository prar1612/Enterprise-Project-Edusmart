/*****************************************************************************************
	Class Name: StudentSearchController_Test
	Purpose: Test class for the StudentSearchController
	******************************************************************************************/
@isTest
public class StudentSearchController_Test {
    public static User u{get;set;}
    public static Student__c stud{get;set;}
	
	/*****************************************************************************************
	Mthod Name: createData
	Purpose: Method to create data for testing
	******************************************************************************************/
    static void createData(){
       u=DataFactory.createUser('Student Profile');
        stud=DataFactory.createStudent(u.id);
    }
	
	/*****************************************************************************************
	Mthod Name: scenario1
	Purpose: Test method for testing the functionality
	******************************************************************************************/
     static testMethod void scenario1(){
       createData();
         StudentSearchController s =new StudentSearchController();
         s.showSMSPopup();
         s.closePopup();
         s.search();
         s.studId=stud.id;
         s.navigateToStudentRecord();
         s.FirstPage();
         s.LastPage();
        // s.previous();
         s.next();
         
      //   s.wrprList.add()
     }

}