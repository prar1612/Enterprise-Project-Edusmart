/*****************************************************************************************
	Class Name: StudentAssignmentViewController_Test
	Purpose: Test class for StudentAssignmentViewController
	******************************************************************************************/
@isTest
public class StudentAssignmentViewController_Test {
     public static User u{get;set;}
    public static Student__c stud{get;set;}
     public static Teacher__c tch{get;set;}
    public static Course__c crs{get;set;}
    public static Assignment__c asn{get;set;}
    public static Submission__c sub{get;set;}
	
	/*****************************************************************************************
	Method Name: createData
	Purpose: Method to create data for testing
	******************************************************************************************/
	 static void createData(){
         u =   DataFactory.createUser('Student Profile');
        stud =  DataFactory.createStudent(u.Id); 
          tch = DataFactory.createTeacher();
        crs = DataFactory.createCourse(tch);
         asn=DataFactory.createAssignment(crs);
         sub=DataFactory.createSubmission(asn, stud);
         
     }
	 
	 /*****************************************************************************************
	Method Name: scenario1
	Purpose: Test method to test functionality
	******************************************************************************************/
    static testMethod void scenario1(){
       createData();
        system.runAs(u){
            System.currentPageReference().getParameters().put('att', asn.Id);
            StudentAssignmentViewController sv =new StudentAssignmentViewController();
            sv.viewSubmission();
            
            Blob b = Blob.valueOf('Test Data');
    		sv.objattachment = new Attachment();
          //  sv.objattachment.ParentId = sub.id;
    	sv.objattachment.Name = 'Test Attachment for Parent';
    	sv.objattachment.Body = b;
            sv.saveAssignment();
            
        }
    }
}