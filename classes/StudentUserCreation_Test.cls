@isTest
public class StudentUserCreation_Test {
    public static Student__c stud{get;set;}
    static void createData(){
        stud = DataFactory.createStudent(NULL);
    }
    static testMethod void scenario1(){
        createData();
        StudentUserCreation.createUser(stud.Id);
    }
}