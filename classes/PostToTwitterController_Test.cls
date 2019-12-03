/*****************************************************************************************
	Class Name: PostToTwitterController_Test
	Purpose: Test class for PostToTwitterController
	******************************************************************************************/
@isTest
public class PostToTwitterController_Test {

	/*****************************************************************************************
	Method Name: createData
	Purpose:Method to create data for testing
	******************************************************************************************/
	static void createData(){
    }
	
	/*****************************************************************************************
	Method Name: scenario1
	Purpose:Test method to test functionality
	******************************************************************************************/
   static testMethod void scenario1(){
       		createData();
           PostToTwitterController tw = new PostToTwitterController();
           tw.status ='test tweet';
           tw.postTweettoTimeline();
       }
}