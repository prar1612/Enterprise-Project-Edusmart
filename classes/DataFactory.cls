/*****************************************************************************************
	Class Name: DataFactory
	Purpose: Class to create data for testing
	******************************************************************************************/
public class DataFactory {
	
	/*****************************************************************************************
	Method Name: createUser
	Purpose: Method to create user record
	******************************************************************************************/
    public static User createUser(String profileName){
        Integer randomNumber = Integer.valueof((Math.random() * 100));
         Profile p = [SELECT Id FROM Profile WHERE Name=:profileName];
         User u = new User(Alias = 'standt', Email='testtrrrr'+randomNumber+'@gmail.com', 
            EmailEncodingKey='UTF-8', LastName='student', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='testrrrr'+randomNumber+'@gmail.com');
            insert u;
        return u;
    }
	
	/*****************************************************************************************
	Method Name: createStudent
	Purpose: Method to create student record
	******************************************************************************************/
    public static Student__c createStudent(Id uId){
        Student__c st = new Student__c();
        st.First_Name__c = 'testFirstName';
        st.Last_Name__c = 'testLastName';
        st.Phone__c = '9999999';
        st.Email__c = 'test@test.com';
        st.Address__c = 'test address';
        st.GRE_Score__c = 311;
        st.Major__c = 'Computer Science';
        st.User__c=uId;
        //Set to 1 in the beginning when application is converted to student
        st.semester__c = '1';
        insert st;
        return st;
    }
	
	/*****************************************************************************************
	Method Name: createTeacher
	Purpose: Method to create teacher record
	******************************************************************************************/
    public static Teacher__c createTeacher(){
        Teacher__c tch = new teacher__c();
        tch.name = 'test teacher';
        tch.Email__c ='test@test.com';
        tch.Phone__c = '9999999999';
        tch.Appointment_availability_Days__c='Mon;Tue';
        insert tch;
        return tch;
    }
	
	/*****************************************************************************************
	Method Name: createCourse
	Purpose: Method to create course record
	******************************************************************************************/
    public static Course__c createCourse(Teacher__c tch){
        Course__c cr = new Course__c();
        cr.Course_Name__c = 'test course';
        cr.Teacher__c = tch.Id;
        insert cr;
        return cr;
        
    }
	
	/*****************************************************************************************
	Method Name: createCourseAssignment
	Purpose: Method to create course assignment record
	******************************************************************************************/
    public static Course_Assignment__c  createCourseAssignment(Course__c crs,Student__c st){
        Course_Assignment__c ca =  new Course_Assignment__c();
        ca.Course__c = crs.id;
        ca.Student__c = st.id;
        insert ca;
        return ca;
    }
	
	/*****************************************************************************************
	Method Name: createInvoice
	Purpose: Method to create course invoice record
	******************************************************************************************/
    public static Invoice__c createInvoice(Student__c stud){
        Invoice__c inv = new Invoice__c();
        inv.Amount__c =4000;
        inv.Student__c = stud.Id;
        inv.Transaction_ID__c = 'test';
        insert inv;
        return inv;
    }
	
	/*****************************************************************************************
	Method Name: createApplication
	Purpose: Method to create course application record
	******************************************************************************************/
    public static Lead createApplication(){
        Lead ld = new lead();
        ld.FirstName = 'testFirstName';
        ld.lastName = 'testLastName';
        ld.Email='test@test.com';
        ld.Phone='99999';
        ld.Street='testStreet';
        ld.City='testCity';
        ld.State='testState';
        ld.Country='testCountry';
        ld.Major__c='Computer Science';
        ld.GRE_Score__c = 311;
        ld.Company='test';
        insert ld;
        return ld;
    }
	
	/*****************************************************************************************
	Method Name: createAppointment
	Purpose: Method to create course appointment record
	******************************************************************************************/
    public static Appointment__c createAppointment(Student__c stud,Teacher__c tch){
        Appointment__c app = new Appointment__c();
        app.student__c = stud.id;
        app.Teacher__c=tch.id;
        app.Date__c=date.today()+1;
        app.Start_Time__c=Time.newInstance(15, 15, 0, 0);
        app.End_Time__c=Time.newInstance(15, 30, 0, 0);
        insert app;
        return app;
    }
	
	/*****************************************************************************************
	Method Name: createAssignment
	Purpose: Method to create course assignment record
	******************************************************************************************/
    public static Assignment__c createAssignment(Course__C crs){
        Assignment__c assn = new Assignment__c();
        assn.Course__c = crs.Id;
        assn.Due_Date__c=date.today()+25;
        assn.Name = 'Assignment 1';
        assn.Questions__c ='What is JAVA?';
        assn.Total_Points__c =30;
        insert assn;
        return assn;
    }
	/*****************************************************************************************
	Method Name: createSubmission
	Purpose: Method to create course submission record
	******************************************************************************************/
    public static Submission__c createSubmission(Assignment__c assn,Student__C stud){
        Submission__c sub = new submission__c();
        sub.Assignment__c=assn.Id;
        sub.Student__c = stud.Id;
        insert sub;
        return sub;
    }
}