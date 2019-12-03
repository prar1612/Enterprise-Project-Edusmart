/*****************************************************************************************
	Class Name: StudentUserCreation
	Purpose: Class called from a button to create new student user
	******************************************************************************************/
global class StudentUserCreation {
    /*****************************************************************************************
	Method Name: StudentUserCreation
	Purpose: Webservice method to create a student user
	******************************************************************************************/
     webservice static void createUser(String studentId) { 
         System.debug('Success');
         Student__c st = [SELECT Id,Email__c,user__c,First_Name__c,Last_Name__c from Student__c where Id =:studentId];
        
          Profile p = [SELECT Id FROM Profile WHERE Name='Student Profile']; 
        User u = new User(Alias = 'standt', Email=st.email__c, 
            EmailEncodingKey='UTF-8', LastName=st.last_name__c, LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName=st.first_name__c+'.'+st.last_name__c+'@edusmart.com',FederationIdentifier=st.first_name__c+'.'+st.last_name__c+'@edusmart.com');
            insert u;
            St.user__c = u.id;
            update st;
            System.resetPassword(u.id, true) ;   
            }
}