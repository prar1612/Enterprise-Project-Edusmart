/*****************************************************************************************
	Class Name: CourseDetailsController_Test
	Purpose: Test class for CourseDetailsController
	******************************************************************************************/
@isTest
public class CourseDetailsController_Test {
    public static teacher__c tch{get;set;}
    public static course__c crs{get;set;}
	
	/*****************************************************************************************
	Method Name: createData
	Purpose: Method to create data for testing
	******************************************************************************************/
	static void createData(){
        tch = DataFactory.createTeacher();
        crs = DataFactory.createCourse(tch);
    }
	
	/*****************************************************************************************
	Method Name: scenario1
	Purpose: Test Method to test the functionality
	******************************************************************************************/
     static testMethod void scenario1(){
       createData();
         System.currentPageReference().getParameters().put('att', crs.Id);
         CourseDetailsController cr = new CourseDetailsController();
		 cr.viewAssignmentDetails();
     }
}