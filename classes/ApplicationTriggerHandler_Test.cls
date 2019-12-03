/*****************************************************************************************
Class Name: ApplicationTriggerHandler_Test
Purpose: Test class for ApplicationTrigger
******************************************************************************************/
@isTest
public class ApplicationTriggerHandler_Test {
    public static Lead ld{get;set;}
	/*****************************************************************************************
	Method Name: createData
	Purpose: Method to create data for testing
	******************************************************************************************/
	 static void createData(){
     	ld = DataFactory.createApplication();
     }
	 
	 /*****************************************************************************************
	Method Name: scenario1
	Purpose: Test method to test the functionality
	******************************************************************************************/
    static testMethod void scenario1(){
       createData();
        ld.Status__c = 'Select';
        update ld;
    }
}