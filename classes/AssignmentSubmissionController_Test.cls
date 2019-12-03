/*****************************************************************************************
Class Name: AssignmentSubmissionController_Test
Purpose: Test class for AssignmentSubmissionController
******************************************************************************************/
@isTest
public class AssignmentSubmissionController_Test {
    public static Assignment__c assn{get;set;}
    public static Course__c crs{get;set;}
    public static Teacher__C tch{get;set;}
    public static Student__c stud{get;set;}
    public static User usr{get;set;}
    public static submission__c sub{get;set;}
	
	/*****************************************************************************************
	Method Name: createData
	Purpose: Method to create data for testing
	******************************************************************************************/
	static void createData(){
        usr = DataFactory.createUser('Student Profile');
        tch = DataFactory.createTeacher();
        crs = DataFactory.createCourse(tch);
        assn = DataFactory.createAssignment(crs);
        stud = DataFactory.createStudent(usr.Id);
        sub = DataFactory.createSubmission(assn,stud);
    }
	
	/*****************************************************************************************
	Method Name: scenario1
	Purpose: Test method to test the functionality
	******************************************************************************************/
     static testMethod void scenario1(){
       createData();
         System.currentPageReference().getParameters().put('att', assn.Id);

         AssignmentSubmissionController assSub = new AssignmentSubmissionController();
         assSub.viewSubmission();
     }
}