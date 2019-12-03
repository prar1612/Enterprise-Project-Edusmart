/*****************************************************************************************
	Class Name: TeacherUserCreation
	Purpose:Class to create user for teacher record
	******************************************************************************************/
global class TeacherUserCreation {
    
	
	/*****************************************************************************************
	Class Name: createUser
	Purpose:Mthod to create user 
	******************************************************************************************/
     webservice static void createUser(String teacherId) { 
         System.debug('Success');
         Teacher__c tchr = [SELECT Id,Name,Phone__c,Email__c,user__c from Teacher__c where Id =:teacherId];
        
          Profile p = [SELECT Id FROM Profile WHERE Name='Teacher Profile']; 
          Integer len = 5;
           String str = string.valueof(Math.abs(Crypto.getRandomLong()));
            String randomNumber = str.substring(0, len);
            String nm = tchr.name.replace(' ','');
        User u = new User(Alias = 'standt', Email=tchr.email__c, 
            EmailEncodingKey='UTF-8', LastName=tchr.name, LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName=nm+randomNumber+'@edusmart.com');
            System.debug('u..'+u.userName);
            insert u;
            tchr.user__c = u.id;
            update tchr;
            System.resetPassword(u.id, true) ;   
            }
}