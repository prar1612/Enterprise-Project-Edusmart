/*****************************************************************************************
Class Name: BookAppointmentController
Purpose: Controller for the BookAppointment VF Page
******************************************************************************************/
public class BookAppointmentController{
    public Id UserId{get;set;}
    public Student__c stud{get;set;}
    public String searchText{get;set;}
    public List<Teacher__c> teacherList {get;set;}
    public Id tchrId{get;set;}
    public Boolean showPopup{get;set;}
    public Boolean showMsg{get;set;}
    public Teacher__c selectedTeacher{get;set;}
    public list<Time> AppointmentTimeList{get;set;}
    public Date appDate {get;set;}
    public String daysAvailable{get;set;}
    public Time selectedTime {get;set;}
    public list<Appointment__c> appList{get;set;}
    public Set<Time> slotSet{get;set;}
    public Boolean showSlots{get;set;}
    public String msg{get;set;}
    public Integer slotSize{get;set;}
    public String selSlot{get;set;}
	
	/*****************************************************************************************
	Method Name: BookAppointmentController
	Purpose: Constructor method
	******************************************************************************************/
    public BookAppointmentController(){
       
        showMsg =  false;
        teacherList =  new List<Teacher__c>();
        UserId = UserInfo.getUserId();
        stud = [SELECT ID,Name,User__c FROM Student__c where User__c=:userId];
        AppointmentTimeList = new List<Time>();
        slotSize = 0;

    }
	
	/*****************************************************************************************
	Method Name: searchForProfessor
	Purpose: method to search for professor to book appointment
	******************************************************************************************/
    public void searchForProfessor(){
        String qryString = 'SELECT Id,Name FROM Teacher__c WHERE ' +
            'Name like \'%' + searchText + '%\'';
        teacherList = Database.query(qryString);

        //teacherList = [SELECT ID,Name from Teacher__c where Name LIKE:tempInput];
        System.debug('teacher List'+teacherList);
        showMsg =  true;
    }
	
	/*****************************************************************************************
	Method Name: bookAnAppointment
	Purpose: method to book appointment
	******************************************************************************************/
    public void bookAnAppointment(){
         daysAvailable ='';
        showpopup = true;
        selectedTeacher = [SELECT ID,Name,Appointment_availability_Days__c,Appointment_availability_End_Time__c,Appointment_Availability_Start_Time__c FROM Teacher__c where id=:tchrId];
        Time tempTime =  selectedTeacher.Appointment_Availability_Start_Time__c;
        while(tempTime < selectedTeacher.Appointment_availability_End_Time__c) {
            //String tempTxt = (String)tempTime;
            AppointmentTimeList.add(tempTime);
            tempTime = tempTime.addMinutes(15);
        }
        list<String> daysList = selectedTeacher.Appointment_availability_Days__c.split(';');
        for(String day : daysList) {
            if(daysAvailable == '') {
                daysAvailable += day;
            }
            else {
                daysAvailable += ','+day;
            }
          
        }
    }
	
	/*****************************************************************************************
	Method Name: closePopup
	Purpose: method to close the book appointment pop up
	******************************************************************************************/
    public void closePopup(){
        showPopup = false;
        appDate = NULL;
        slotSet.clear();
        selectedTeacher =NULL;
        AppointmentTimeList.clear();
        slotSize = 0;
        selSlot=NULL;
        selectedTime = NULL;

    }
	
	/*****************************************************************************************
	Method Name: showAvailableSlots
	Purpose: method to show list of available slots for selected date
	******************************************************************************************/
   public void showAvailableSlots(){
       slotSize =0;
       showSlots = true;
      slotSet =  new Set<Time>();
       msg = NULL;
      if(appDate != NULL && appDate > date.today()) {
       if(!AppointmentTimeList.isEmpty()) {
           slotSet.addAll(AppointmentTimeList);
           appList = [SELECT ID,Name, Start_Time__c,End_Time__c,Date__c,Student__c,Teacher__c from Appointment__c where Teacher__c=:selectedTeacher.Id AND Date__c=:appDate] ;
           System.debug('appDate..'+appDate);
           DateTime myDateTime = DateTime.newInstance(appDate, Time.newInstance(0, 0, 0, 0));
            String dayOfWeek = myDateTime.format('E');
           System.debug('dayOfWeek..'+dayOfWeek);
           if(selectedTeacher.Appointment_availability_Days__c.contains(dayOfWeek)) {
                System.debug('appList...'+appList);
                for(Time t :AppointmentTimeList) {
                    for(Appointment__c app : appList){
                        System.debug('t..'+t+'app...'+app.start_time__c);
                        if(t == app.start_time__c) {
                       slotSet.remove(t);
                   }
               }
           }
           if(slotSet.isEmpty()) {
               msg = 'No appointments available on selected date.';
           }
           else {
               msg =NULL;
               slotSize = slotSet.size();
           }
           }
           else {
              slotSet.clear();
              msg = 'No Appointments Available on selected Date';
           }
           
       }
   }
   else{
       if(appDate == NULL){
           msg = 'Please enter a date to view the available list of appointments.';
       }
       else if(appDate <= Date.Today()){
           msg = 'Please select a future date to book an appointment';
       }
   }
   }
   
   /*****************************************************************************************
	Method Name: selectedSlot
	Purpose: method to get selected slot
	******************************************************************************************/
   public void selectedSlot() {
		list<Time>timeList = new List<Time>();
		timeList.addAll(slotSet);
		selSlot=Apexpages.currentPage().getParameters().get('selSlot');
		selectedTime = timeList[Integer.valueOf(selSlot)];
   }
   
    /*****************************************************************************************
	Method Name: saveAppointment
	Purpose: method to save the appointment and create a record
	******************************************************************************************/
    public PageReference saveAppointment(){
        Appointment__c app = new Appointment__c();
        app.Student__c = stud.Id;
        app.Teacher__c = selectedTeacher.Id;
        app.Date__c = appDate;
        app.Start_Time__c = selectedTime;
        app.End_Time__c = selectedTime.addMinutes(15);
        insert app;
        PageReference pf = new PageReference('/'+app.Id);
        return pf; 

    }
}