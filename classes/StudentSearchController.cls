/*****************************************************************************************
	Class Name: StudentSearchController
	Purpose: Controller for the StudentSearch VF Page
	******************************************************************************************/
public class StudentSearchController{
    private integer totalRecs = 0;
    private integer OffsetSize = 0;
    private integer LimitSize= 25;
    public list<SearchWrapper> wrprList{get;set;}
    public list<Student__c>studList{get;set;}
    public String semester{get;set;}
    public Course__c cr{get;set;}
    public Id studId{get;set;}
    public string studPhone{get;set;}
    public Boolean showPopup{get;set;}
    public String textMessageBody{get;set;}
	
	/*****************************************************************************************
	Method Name: StudentSearchController
	Purpose: Constructor method
	******************************************************************************************/
    public StudentSearchController()
    {
        textMessageBody='';
        cr = new course__c();
        semester = null;
        totalRecs = [select count() from student__c];
        wrprList = new List<SearchWrapper>();
        SearchWrapper sw =  new SearchWrapper();
        wrprList.add(sw);
        studList=new list<Student__c>();
    }
	
	/*****************************************************************************************
	Method Name: showSMSPopup
	Purpose: Method to show the SMS Popup
	******************************************************************************************/
    public void showSMSPopup(){
        showPopup =  true;
    }
	
	/*****************************************************************************************
	Method Name: sendSMS
	Purpose: Method to send SMS through Twillio
	******************************************************************************************/
    public void sendSMS(){
        
        String account = Label.Twilio_Account_ID;
        String token = Label.Twilio_Token;
        TwilioRestClient client = new TwilioRestClient(account, token);
        
        Map<String,String> params = new Map<String,String> {
                'To'   => studPhone,
                'From' => '+12566079818',
                'Body' => textMessageBody
            };
        TwilioSMS sms = client.getAccount().getSMSMessages().create(params);
        showPopup=false;
    
    }
	
	/*****************************************************************************************
	Method Name: closePopup
	Purpose: Method to close the SMS Popup
	******************************************************************************************/
     public void closePopup(){
      showpopup=false;
  } 
  
	/*****************************************************************************************
	Method Name: search
	Purpose: Method to search for a student based on certain criteria
	******************************************************************************************/
    public void search(){
        String major  = cr.major__c;
        System.debug('semester...'+semester);
        System.debug('major..'+cr.major__c);
        System.debug('wrapperList...'+wrprList);
        if(wrprList.isEmpty() && (semester == null || semester =='') && cr.major__c ==null){
          studList = Database.Query('SELECT ID,Name,Address__c,Email__c,GRE_Score__c,Major__c,Phone__c,Semester__c,User__c,First_Name__c,Last_Name__c FROM Student__c LIMIT :LimitSize OFFSET :OffsetSize');
       
       }
       else{
           if(wrprList.size() ==1){
               if(wrprList[0].searchBy == null  && (semester == null || semester =='') && cr.major__c ==null){
                   studList = Database.Query('SELECT ID,Name,Address__c,Email__c,GRE_Score__c,Major__c,Phone__c,Semester__c,User__c,First_Name__c,Last_Name__c FROM Student__c LIMIT :LimitSize OFFSET :OffsetSize');

               }
           
           else {
               String queryString = 'SELECT ID,Name,Address__c,Email__c,GRE_Score__c,Major__c,Phone__c,Semester__c,User__c,First_Name__c,Last_Name__c FROM Student__c ';
               for(SearchWrapper sw : wrprList){
                   if(sw.searchBy != NULL)
                   queryString +='WHERE '+sw.searchBy+' like \'%' + sw.searchText + '%\'';
                   
               }
               if(semester != NULL && semester !=''){
                   if(queryString.contains('WHERE')) {
                       queryString+= 'AND semester__c=:semester ';
                   }
                   else {
                       queryString+= 'WHERE semester__c=:semester ';
                   }
               }
               if(major != NULL) {
                   if(queryString.contains('WHERE')) {
                       queryString+= 'AND major__c=:major';
                   }
                   else {
                       queryString+= 'WHERE major__c=:major';
                   }
               }
               queryString+=' LIMIT :LimitSize OFFSET :OffsetSize';
               system.debug('qs...'+querystring);
               studList =Database.query(queryString);
               System.debug('queryString...'+queryString);
           }
       }
       
    }
    }
	/*****************************************************************************************
	Method Name: navigateToStudentRecord
	Purpose: Method to navigate to selected student record
	******************************************************************************************/
     public PageReference navigateToStudentRecord(){
        PageReference pf = new PageReference('/'+studId);
        return pf;
     }
	/*****************************************************************************************
	Method Name: FirstPage
	Purpose: Method to navigate to the first page
	******************************************************************************************/ 
    public void FirstPage()
    {
        OffsetSize = 0;
        search();
    }
	
	/*****************************************************************************************
	Method Name: previous
	Purpose: Method to navigate to the previous page
	******************************************************************************************/ 
    public void previous()
    {
        OffsetSize = OffsetSize - LimitSize;
        search();
    }
	
	/*****************************************************************************************
	Method Name: next
	Purpose: Method to navigate to the next page
	******************************************************************************************/ 
    public void next()
    {
        OffsetSize = OffsetSize + LimitSize;
        search();
    }
	
	/*****************************************************************************************
	Method Name: LastPage
	Purpose: Method to navigate to the last page
	******************************************************************************************/ 
    public void LastPage()
    {
        OffsetSize = totalrecs - math.mod(totalRecs,LimitSize);
        search();
    }
	
	/*****************************************************************************************
	Method Name: getprev
	Purpose: Method to determine whether to display the previous button
	******************************************************************************************/ 
    public boolean getprev()
    {
        if(OffsetSize == 0)
            return true;
        else
            return false;
    }
	
	/*****************************************************************************************
	Method Name: getnxt
	Purpose: Method to determine whether to display the next button
	******************************************************************************************/ 
    public boolean getnxt()
    {
        System.debug('1..'+OffsetSize +'..'+LimitSize+'..'+totalRecs);
        if(studList.size()<LimitSize)
            return true;
        if((OffsetSize + LimitSize) > totalRecs)
            return true;
        else
            return false;
    }
	
	/*****************************************************************************************
	Class Name: SearchWrapper
	Purpose: Wrapper class
	******************************************************************************************/ 
    public class SearchWrapper{
        public String searchBy{get;set;}
        public String searchText{get;set;}
        
	/*****************************************************************************************
	Method Name: getSearchByOptions
	Purpose: Method to get the search by options
	******************************************************************************************/ 
        public list<SelectOption> getSearchByOptions(){
            List<SelectOption> optList =  new list<SelectOption>();
            SelectOption opt1 = new SelectOption('','--None--');
            SelectOption opt2 = new SelectOption('First_Name__c','First Name');
            SelectOption opt3 = new SelectOption('Last_Name__c','Last Name');
           
            optList.add(opt1);
            optList.add(opt2);
            optList.add(opt3);
            return optList;
        }
    }
    
}