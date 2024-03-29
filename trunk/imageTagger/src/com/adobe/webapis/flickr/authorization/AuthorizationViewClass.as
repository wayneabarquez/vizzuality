	import com.adobe.webapis.flickr.FlickrService;
	import com.adobe.webapis.flickr.events.FlickrResultEvent;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	import mx.core.Application;
	
	
	/************ Panel State Constants ****************/
	
	//initial state
	private static const START_STATE:String = "";
	
	//settings error state - if required settings are not set
	private static const SETTINGS_ERROR_STATE:String = "settingsErrorState";
	
	//progress state - why waiting for response for server
	private static const AUTHORIZATION_STATE:String = "authorizationState";
	
	//state view to launch flickr in browser for authorization
	private static const URL_AUTHORIZATION_STATE:String = "urlAuthorizationState";
	
	//state view to start the process to get the authorization token
	private static const GET_TOKEN_STATE:String = "gettokenState";
	
	//authorization has been completed
	private static const AUTHORIZATION_COMPLETE_STATE:String = "authorizationCompleteState";
	
	//state view in case any errors occur
	private static const ERROR_STATE:String = "errorState";
	
	/******** private vars ************/
	
	private var _settings:FlickrAuthorizationSettings;
	
	//flickr api instance
	private var flickr:FlickrService;
	
	//authorization url for user authorization
	private var authorizationURL:String;
	
	//frob returned from flickr
	private var frob:String;
	
	public var flickrAPIKey:String = Application.application.flickrAdminKey;
	public var flickrAPISecret:String = Application.application.flickrSecretKey;
	private var timer: Timer;
	
	

	//when cancel button is clicked
	private function onCancelClick():void
	{
	        closeWindow();
	}
	
	
	//event handler called to start authorization process
	private function onAuthorizationStartClick():void
	{     
	        //make sure the settings we need to authorize have been set
	        if(flickrAPIKey == null || flickrAPIKey.length == 0 ||
	                flickrAPISecret == null || flickrAPISecret.length == 0)
	        {
	                //if not, then go to the error state view
	                currentState = SETTINGS_ERROR_STATE;
	                return;
	        }		    
		        
	        //change state
	        currentState = AUTHORIZATION_STATE;
	        
	        //initialize flickr instance
	        flickr = new FlickrService(flickrAPIKey);
	        flickr.secret = flickrAPISecret;
	        
	        //register for events
	        flickr.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
	        flickr.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
	        flickr.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatus);                                     
	        flickr.addEventListener(FlickrResultEvent.AUTH_GET_FROB, onGetFrob);
	        
	        //retrieve frob from flickr. This goes to the flickr server, and is async
	        flickr.auth.getFrob();                          
	        
	        //update progress bar
	        pBar.label = "Retrieving Frob from Flickr";
	 	
	        
	}
	
	//handles any IOErrors while communicating with flickr
	private function onIOError(e:ErrorEvent):void
	{
	        //send an error, with info on error
	        setError(e.text);
	}
	
	//handles any security errors that occur while communicating with flickr
	private function onSecurityError(e:SecurityErrorEvent):void
	{
	        //send an error, with info on error
	        setError(e.text);
	}
	
	//handles any errors that occur in response to http status responses
	//from server
	private function onHTTPStatus(e:HTTPStatusEvent):void
	{
	        //send an error, with info on error
	        setError("HTTP Status : " + e.status);
	}
	
	//called when the frob is returned from flickr
	private function onGetFrob(e:FlickrResultEvent):void
	{
	        //save the frob in class instance
	        frob = e.data.frob;
	        
	        //create the authorization url using the frob
	        authorizationURL = flickr.getLoginURL(frob, "write");
	        
	        //switch to the url auth state to prompt the user to launch flickr
	        //in their browser
	        currentState = URL_AUTHORIZATION_STATE;
	}
	
	
	private function onClickCancelButton():void {
		web.location="";
		currentState=GET_TOKEN_STATE;
	}
	
	private function confirmAuthorization(ev: Event): void {
		
		var urlAuth: String = "http://www.flickr.com/services/auth/";
		
		trace(web.location);
		if (web.location == urlAuth) {onGetTokenClick();}
		
	}
	
	//called when the user clicks the button to launch flickr in the browser
	//to authorize the app
	private function onLaunchFlickrClick():void{
		
			web.location=authorizationURL;
			web.addEventListener(flash.events.Event.COMPLETE,confirmAuthorization);
	}                   
	
	//called when the user clicks the button to retrieve the authorization token
	//from flickr
	private function onGetTokenClick():void
	{
	        //change state to show progress bar
	        currentState = AUTHORIZATION_STATE;
	        
	        //set progress bar label
	        pBar.label = "Retrieving Application Token from Flickr";
	        
	        //register for event when token is returned
	        flickr.addEventListener(FlickrResultEvent.AUTH_GET_TOKEN, onGetToken);
	        
	        //request token from flickr api. This goes to the flickr server and is
	        //async
	        flickr.auth.getToken(frob);
	}
	
	
	//called when the response is received from flickr after request authorization
	//token
	private function onGetToken(e:FlickrResultEvent):void
	{
	        //check and see if token was returned
	        if(e.data.auth == null)
	        {
	                //if not, there was an error, or it was rejected
	                //send error with info
	                setError(e.data.error.errorMessage);
	                return;
	        }
	        
	        Application.application.user = e.data.auth.user;
	        Application.application.token = e.data.auth.token;
	        
	        //change state to authorization complete
	        currentState = AUTHORIZATION_COMPLETE_STATE;
	}
	
	//called when the user clicks the open settings button from the auth panel
	private function onOpenSettingsClick():void
	{
	        
	        //close window
	        closeWindow();
	}
	
	//close button handler
	private function onCloseClick():void
	{
		timer.stop();
		Application.application.onAuthorizationComplete();
	}
	
	//handler for try again button, which is present when authorization fails
	private function onTryAgainClick():void
	{       
	        //reinitialize state of panel
	        frob = null;
	        authorizationURL = null;
	        
	        //return to start state;
	        currentState = START_STATE;
	}
	
	
	/************ General functions **************/
	
	//broadcast close event
	private function closeWindow():void
	{
	        NativeApplication.nativeApplication.exit();
	}
	
	//sends an error event with information about the error
	private function setError(msg:String):void
	{
	        //Log.getLogger(AIRSnapshot.LOG_NAME).error("AuthorizationView : " + msg);
	        currentState = ERROR_STATE;
	        errorField.text = "Error : " + msg;
	}
	
	private function exitTimer():void {
		timer = new Timer(1000,10);
		timer.addEventListener(TimerEvent.TIMER_COMPLETE,completeTimer);
		timer.start();
	}
	private function completeTimer(ev:TimerEvent):void {
		onCloseClick();
	}