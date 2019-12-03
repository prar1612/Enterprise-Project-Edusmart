/*****************************************************************************************
	Class Name: PostToTwitterController
	Purpose: Controller for PosToTwitterPage
	******************************************************************************************/
public with sharing class PostToTwitterController 
{
    public String twitterStatus {set; get;}
    public String status {set; get;}
    public String errorMessage {set; get;}
    public Boolean success{get;set;}
     
	 /*****************************************************************************************
	Method Name: PostToTwitterController
	Purpose: Constructor method
	******************************************************************************************/
     public PostToTwitterController(){
         success = false;
     }
	 
	 /*****************************************************************************************
	Method Name: postTweettoTimeline
	Purpose: Method to call the webservice and post to twitter
	******************************************************************************************/
     public void postTweettoTimeline() {
         Boolean twitterFlag = false;
         TweetUtil tu = new TweetUtil(Label.Twitter_Consumer_Key, 
                     Label.Twitter_Consumer_Secret, 
                     Label.Twitter_Access_Key, 
                     Label.Twitter_Access_Secret);

        twitterFlag = tu.sendTweet(status, null);
         if(twitterFlag == true)
         {
             success = true;
             twitterStatus = status;
             status='';
         }
         
   
 }

}