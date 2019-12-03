/*****************************************************************************************
	Class Name: TeacherUserCreation_Test
	Purpose:Test class for TeacherUserCreation class
	******************************************************************************************/
@isTest
public class TeacherUserCreation_Test {
    public static Teacher__c tch {get;set;}
	
	/*****************************************************************************************
	Class Name: createData
	Purpose:Method to create data for testing
	******************************************************************************************/
    static void createData(){
        tch = DataFactory.createTeacher();
        
    }
	
	/*****************************************************************************************
	Class Name: scenario1
	Purpose:Method to test the functionality
	******************************************************************************************/
     static testMethod void scenario1(){
        createData();
        TeacherUserCreation.createUser(tch.Id);
    }
}