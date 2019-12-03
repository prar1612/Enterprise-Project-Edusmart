/*****************************************************************************************
	Class Name: CourseDetailsTeacherViewController_Test
	Purpose: Test class for CourseDetailsTeacherViewController
	******************************************************************************************/
@isTest
public class CourseDetailsTeacherViewController_Test {
    public static teacher__c tch{get;set;}
    public static course__c crs{get;set;}
    public static assignment__c asn{get;set;}
	
	/*****************************************************************************************
	Method Name: createData
	Purpose: Method to create data for testing
	******************************************************************************************/
	static void createData(){
         tch = DataFactory.createTeacher();
        crs = DataFactory.createCourse(tch);
        asn = DataFactory.createAssignment(crs);
        
    }
	
	/*****************************************************************************************
	Method Name: scenario1
	Purpose: Test method for testing functionality
	******************************************************************************************/
     static testMethod void scenario1(){
       createData();
         System.currentPageReference().getParameters().put('att', crs.Id);
         CourseDetailsTeacherViewController cr = new CourseDetailsTeacherViewController();
         cr.createAssignment();
         cr.viewSubmissions();
         cr.closePopup();
         cr.saveAssignment();
         cr.assmntId = asn.Id;
          cr.createAssignment();
         cr.newAssignment = asn;
          cr.saveAssignment();
         
     }
}