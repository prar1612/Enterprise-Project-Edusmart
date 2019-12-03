/*****************************************************************************************
	Class Name: FeePaymentController_Test
	Purpose: Test class for FeePaymentController
	******************************************************************************************/
@isTest
public class FeePaymentController_Test {
    public static User u{get;set;}
    public static student__c stud{get;set;}
	
	/*****************************************************************************************
	Method Name: createData
	Purpose: Method to create data for testing
	******************************************************************************************/
	static void createData(){
        u = DataFactory.createUser('Student Profile');
        stud = DataFactory.createStudent(u.Id);
    }
	
	/*****************************************************************************************
	Method Name: scenario1
	Purpose: test method for testing the functionality
	******************************************************************************************/
     static testMethod void scenario1(){
         createData();
         system.runAs(u){
             System.currentPageReference().getParameters().put('att', stud.Id+',4000');
             FeePaymentController fee = new FeePaymentController();
             fee.txnId='test';
			 fee.makePayment();
            
         }
     }
}