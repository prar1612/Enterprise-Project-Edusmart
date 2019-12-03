/*****************************************************************************************
Class Name: ApplicationTriggerHandler
Purpose: Handler class for ApplicationTrigger
******************************************************************************************/
public class ApplicationTriggerHandler {
	/*****************************************************************************************
	Method Name: convertToStudent
	Purpose: Method to convert application to student
	******************************************************************************************/
    public static void convertToStudent(Map<Id,Lead>oldMap,Map<Id,Lead>newMap){
        set<Id> leadIdSet = new set<Id>();
        list<Lead> leadList = new list<Lead>();
        for(Lead ld: newMap.values()) {
            if(oldMap.containsKey(ld.Id)) {
                if(oldMap.get(ld.Id).Status__c != ld.Status__c && ld.Status__c == 'Select') {
                    leadIdSet.add(ld.Id);
                }
                
            }
        }
        if(!leadIdSet.isEmpty()) {
            leadList = [SELECT ID,FirstName,LastName,Phone,Email,Street,City,State,PostalCode,Country,GRE_Score__c,Major__c,Status__c FROM Lead where ID in:leadIdSet ];
            List<Student__c> studentList = new List<Student__c>();
            if(!leadList.isEmpty()) {
                for(Lead ld: leadList) {
                    Student__c st = new Student__c();
                    //copy details from application to the Student Object
                    st.First_Name__c = ld.FirstName;
                    st.Last_Name__c = ld.LastName;
                    st.Phone__c = ld.Phone;
                    st.Email__c = ld.Email;
                    st.Address__c = ld.Street+' '+ld.City+' '+ld.State+' '+ld.Country+' '+ld.PostalCode;
                    st.GRE_Score__c = ld.GRE_Score__c;
                    st.Major__c = ld.Major__c;
                    //Set to 1 in the beginning when application is converted to student
                    st.semester__c = '1';
                    studentList.add(st);
                }
                insert studentList;
            }
        }
    }
    /*****************************************************************************************
	Method Name: assignToEvaluator
	Purpose: Method to assign an application to the appropriate evaluator
	******************************************************************************************/
    public static void assignToEvaluator(map<Id,Lead>leadMap){
        list<Lead> leadList = [SELECT ID,Major__c,Assigned_Evaluator__c from lead where id in:leadMap.keySet()];
        map<String,ID>userMap = new map<String,Id>();
        list<User> userList = [SELECT ID,Name,Major__c from User where Profile.name='Student Evaluator' LIMIT 100];
        for(User u: userList){
            userMap.put(u.major__c,u.id);
        }
        for(Lead ld: leadList) {
            if(userMap.containsKey(ld.Major__c)){
                ld.Assigned_Evaluator__c=userMap.get(ld.Major__c);
            }
            
        }
        update leadList;
    }

}