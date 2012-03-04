//
//  SettingsViewController.m
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 3/4/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import "SettingsViewController.h"
#import "PhotoTwistAppDelegate.h"


@implementation SettingsViewController
@synthesize facebookConnectSwitch;

-(void)viewDidAppear:(BOOL)animated
{
    PhotoTwistAppDelegate *appDelegate = (PhotoTwistAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) 
    {
        appDelegate.facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        appDelegate.facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
        if ([appDelegate.facebook isSessionValid]) facebookConnectSwitch.on = YES;
        else facebookConnectSwitch.on = NO;
    }else
        facebookConnectSwitch.on = NO;
    
}
- (IBAction)facebookConnectSwitchOnOff:(UISwitch *)sender 
{
    PhotoTwistAppDelegate *appDelegate = (PhotoTwistAppDelegate *)[[UIApplication sharedApplication]delegate];
    if (sender.on) //Log in to FB
    {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"FBAccessTokenKey"] 
            && [defaults objectForKey:@"FBExpirationDateKey"]) 
        {
            appDelegate.facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
            appDelegate.facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
        }
        if (![appDelegate.facebook isSessionValid]) 
        {
            NSArray *permissions = [[NSArray alloc] initWithObjects:
                                    @"publish_stream", 
                                    nil];
            [appDelegate.facebook authorize:permissions];
            //[appDelegate.facebook authorize:nil];
        }
    }//End on Sender ON.
    else
        [appDelegate.facebook logout];
}

- (void)viewDidUnload {
    [self setFacebookConnectSwitch:nil];
    [super viewDidUnload];
}
@end
















