//
//  FlickrWebViewController.m
//  SpeciesLog
//
//  Created by Administrador on 28/01/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//
#import <SystemConfiguration/SystemConfiguration.h>
#import <UIKit/UIKit.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>

#import "FlickrWebViewController.h"
#import "MD5Class.h"
#import "XMLParser.h"
#import "NetworkConn.h"
#import "LoadIconClass.h"

@implementation FlickrWebViewController

@class SpeciesLogAppDelegate;

@synthesize token;
@synthesize secret;
@synthesize api_key;
@synthesize frob;
@synthesize webView;






/*
-(id) init
{
	if(self=[super init])
	{
		secret=  @"f8ed2994c7cd8caa";
		api_key =@"aaf19680e376aba3c1bbfd18dc6ec2f0";
		
		printf("SECRETO:%s",[secret UTF8String]);
		
	}
	return self;
}
*/
//@class MD5Class;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) 
	{
        self.navigationController.navigationBar.barStyle=UIBarStyleBlackOpaque;	
    }
    return self;
}*/


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}                
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{	
	[super viewDidLoad];			
}

- (void)viewWillAppear:(BOOL)animated
{ 	
	//[LoadIconClass presentHUD:self.view	Text:@"Checking network status "];
}
- (void)viewDidAppear:(BOOL)animated 
{
	[LoadIconClass startThreadHUD:self.view Text:@"Cheking network status"];
	[NSThread detachNewThreadSelector:@selector(checkNetwork) toTarget:self withObject:nil];
	//[self	checkNetwork];
}
-(void) checkNetwork
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	//CARGAMOS EL MAIN BUNDLE
	NSBundle *bundle = [NSBundle mainBundle];
	NSDictionary *info = [bundle infoDictionary];
	
	//CARGAMOS EL APIKEY Y EL SECRET
	secret=[info objectForKey: @"FlikcrSecret"];
	api_key =[info objectForKey: @"FlickrApiKey"];
	NSString* _token=[[NSUserDefaults standardUserDefaults]objectForKey:@"FlickrToken"];
	token=[_token copy];
	
	//VERIFICAMOS ESTADO DE LA CONEXION CON FLIKCR
	BOOL connection=[NetworkConn connectionWithFlickr];	
	if(_token)
	{	
		if(connection==YES)
		{
			//CON ESTE TOKEN FALLA 
			//token=@"72157613307681440-ca6f8785e3739894";
			NSString* api_sig = [MD5Class stringToMD5:[NSString stringWithFormat:@"%@api_key%@auth_token%@methodflickr.auth.checkToken",secret,api_key,token]];
			NSString* stringUrl=[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.auth.checkToken&api_key=%@&auth_token=%@&api_sig=%@",api_key,token,api_sig];
			NSURL* urlFrob=[NSURL URLWithString:stringUrl];
			XMLParser* 	xmlData=[[XMLParser alloc]init];
			NSString *res=[[xmlData parseXMLFile:urlFrob] copy];
			[LoadIconClass killThreadHud];
			if([ xmlData.statValue isEqualToString:@"ok"])
				[self performSelectorOnMainThread:@selector(goToMainApp) withObject:nil waitUntilDone:YES];
			else
				[self performSelectorOnMainThread:@selector(showAlert:) withObject:[NSNumber numberWithInt:VERIFY_TOKEN]  waitUntilDone:YES];
		}
		else //NO PODEMOS VERIFICAR SI EL TOKEN ES O NO CORRECTO
		{
			[LoadIconClass killThreadHud];
			[self performSelectorOnMainThread:@selector(showAlert:) withObject:[NSNumber numberWithInt:FLICKER_UNABLE]  waitUntilDone:YES];
		}
	}
	else
	{
		[LoadIconClass killThreadHud];
		if(connection==YES)
			[self performSelectorOnMainThread:@selector(showAlert:) withObject:[NSNumber numberWithInt:REGISTER_REQUEST]  waitUntilDone:YES];
		else //NO PODEMOS VERIFICAR SI EL TOKEN ES O NO CORRECTO
			[self performSelectorOnMainThread:@selector(showAlert:) withObject:[NSNumber numberWithInt:EXIT_APP]  waitUntilDone:YES];
	}	
	[pool release];	 
}


-(void) AuthProcess
{
	//secret=[NSString stringWithString:@"f8ed2994c7cd8caa"];
	//api_key = [NSString stringWithString:@"aaf19680e376aba3c1bbfd18dc6ec2f0"];	
	NSString* api_sig = [MD5Class stringToMD5:[NSString stringWithFormat:@"%sapi_key%smethodflickr.auth.getFrob",[secret UTF8String],[api_key UTF8String]]];
	NSString* stringUrlFrob=[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.auth.getFrob&api_key=%s&api_sig=%s",[api_key UTF8String],[api_sig UTF8String]];
	NSURL* urlFrob=[NSURL URLWithString:stringUrlFrob];
	XMLParser* 	xmlData=[[XMLParser alloc]init];
	frob=[[xmlData parseXMLFile:urlFrob] copy];
	printf("FROB DEVUELTO:%s\n",[frob UTF8String]);
	
	NSString* api_sig2 = [MD5Class stringToMD5:[NSString stringWithFormat:@"%@api_key%@frob%@permswrite",secret,api_key,frob]];	
	NSString* stringUrlAuth=[NSString stringWithFormat:@"http://flickr.com/services/auth/?api_key=%@&perms=write&frob=%@&api_sig=%@",api_key,frob,api_sig2];
	printf("\nURL AUTH:%s",[ stringUrlAuth UTF8String]);
	NSURL* urlAuth=[NSURL URLWithString:stringUrlAuth];
	NSURLRequest* requestObj=[NSURLRequest requestWithURL:urlAuth];
	[webView setDelegate:self];
	[webView loadRequest:requestObj];
	
}

-(IBAction)getToken
{
	if( [LoadIconClass isLoading]==NO)
	{
	//[LoadIconClass presentHUD:self.view Text:@"Waitting to Flickr response. Please wait..."];
	NSString* api_sig = [MD5Class stringToMD5:[NSString stringWithFormat:@"%@api_key%@frob%@methodflickr.auth.getToken",secret,api_key,frob]];
	NSString* stringUrlToken=[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.auth.getToken&api_key=%@&frob=%@&api_sig=%@",api_key,frob,api_sig];
	printf("\nURL TOKEN:%s",[stringUrlToken UTF8String]);
	NSURL* urlToken=[NSURL URLWithString:stringUrlToken];
	XMLParser* 	xmlData=[[XMLParser alloc]init];
	NSString* _token=[[xmlData parseXMLFile:urlToken] copy];
	//[LoadIconClass killHUD];
	if([xmlData.statValue isEqualToString:@"ok"])
	{
		token=[_token copy];
		[[NSUserDefaults standardUserDefaults]setObject:token forKey:@"FlickrToken"];
		[[NSUserDefaults standardUserDefaults]synchronize];
		printf("\nTOKEN ESCRITO EN DISCO:%s\n",[token UTF8String]);	
		
		[self showAlert:[NSNumber numberWithInt:REGISTER_SUCESS]];
		[self goToMainApp];
		//REDIRIGIR AL PPAL
	}
	else
	{
		[self showAlert:[NSNumber numberWithInt:TOKEN_DONE_ERROR]];
		//[self showAlert:TOKEN_DONE_ERROR];
		
	}	
	}
}

- (void)webViewDidStartLoad:(UIWebView *)_webView
{
	[LoadIconClass presentHUD:self.view Text:@"Accesing Flicker. Please wait..."];
	
}
- (void)webViewDidFinishLoad:(UIWebView *)_webView
{	
	[LoadIconClass killHUD];
	NSString *currentURL= webView.request.URL.absoluteString;
	printf("\nURL:%s",[currentURL UTF8String]);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{	
	printf("ERROR AL CARGAR LA PAGINA");
	[self showAlert:[NSNumber numberWithInt:EXIT_APP]];
}

-(void) showAlert:(NSNumber*)num
{
	int numMsg=[num intValue];
	if(numMsg==VERIFY_TOKEN)//TOKEN:SI RED:SI-> VERIFICAR: Boton de registro o salir.
	{
		alert =[[UIAlertView alloc] initWithTitle:@"Token Revocated" message:@"Register SpeciesLoc in Flickr again" delegate:self cancelButtonTitle:@"EXIT" otherButtonTitles:@"Register",nil];
	}
	else if(numMsg==FLICKER_UNABLE)//TOKEN:SI RED:NO-> PUEDE HACER FOTOS PERO NO SUBIRLAS.
	{
		alert =[[UIAlertView alloc] initWithTitle:@"Unable to access Flickr" message:@"Can take and storage photos, but cannot upload them" delegate:self cancelButtonTitle:@"EXIT" otherButtonTitles:@"Continue",nil];
	}
	else if(numMsg==REGISTER_REQUEST)//TOKEN:NO RED:SI-> REGISTRAR APLICACION.
	{
		alert =[[UIAlertView alloc] initWithTitle:@"Register Request" message:@"Register SpeciesLoc in Flickr" delegate:self cancelButtonTitle:@"EXIT" otherButtonTitles:@"Register",nil];
	}
	else if(numMsg==EXIT_APP)//TOKEN:NO RED:NO-> IMPOSIBLE HACER NADA, SALIR FUERA.
	{
		alert =[[UIAlertView alloc] initWithTitle:@"Network Fail" message:@"Unable to access Flicker. Connected to Internet?" delegate:self cancelButtonTitle:@"EXIT" otherButtonTitles:nil];
	}
	else if(numMsg == TOKEN_DONE_ERROR)
	{
		alert =[[UIAlertView alloc] initWithTitle:@"Register Error" message:@"SpeciesLog could not register in Flickr. Try again process" delegate:self cancelButtonTitle:@"EXIT" otherButtonTitles:@"Try again",nil];
	}
	else if(numMsg == REGISTER_SUCESS)
	{
		alert =[[UIAlertView alloc] initWithTitle:@"Register Success" message:@"SpeciesLog in now registered in Flickr. Enjoy" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	}
	[alert show];
	[alert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{	

	if(buttonIndex == 0 && [ alertView.title isEqualToString:@"Register Success"]==NO)
	{
		[[UIApplication sharedApplication] terminate];
	}
	else if([ alertView.title isEqualToString:@"Token Revocated"])
	{
		[self AuthProcess];
	}
	else if([ alertView.title isEqualToString:@"Unable to access Flickr"])
	{
		//CONTINUAR SIN REGISTRAR
		[self goToMainApp];
	}
	else if([ alertView.title isEqualToString:@"Register Request"])
	{
		[self AuthProcess];
	}
	else if([ alertView.title isEqualToString:@"Network Fail"])
	{
	}
	else if([ alertView.title isEqualToString:@"Register Error"])
	{
		[self AuthProcess];
	}	
}
-(void) goToMainApp
{
	SpeciesLogAppDelegate* sp=[[UIApplication sharedApplication] delegate];
	[sp loadMainApp];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}



@end
