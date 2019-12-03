/*****************************************************************************************
	Class Name: SurveyComponentController_Test
	Purpose:Test class for SurveyComponentController
	******************************************************************************************/
@isTest
public class SurveyComponentController_Test {

	/*****************************************************************************************
	Method Name: scenario1
	Purpose:Method to test the functionality
	******************************************************************************************/
    static testMethod void scenario1(){
       createData();
        SurveyComponentController sur = new SurveyComponentController();
        sur.SendEmail();
        sur.clearSurveyResults();
        sur.retrieveSurveyResults();
        sur.showReport();
    }
}