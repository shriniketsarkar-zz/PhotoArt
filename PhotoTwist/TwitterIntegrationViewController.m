//
//  TwitterIntegrationViewController.m
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 3/3/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import "TwitterIntegrationViewController.h"
#import <Twitter/Twitter.h>
#import "SVProgressHUD.h"
@implementation TwitterIntegrationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    //Twitter Post for PhotoArt
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init]; 
    [twitter setInitialText:@"Guys, I am using PhotoArt app for creating Collage with photos and awesome photo art.Try this app at..."]; 
    [twitter addURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.google.com"]]]; 
    
    if([TWTweetComposeViewController canSendTweet]) 
        [self presentViewController:twitter animated:YES completion:nil]; 
    else
    { 
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Unable to tweet" message:@"Please log in to Twitter from you iPhones Settings." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil]; 
        [alertView show]; 
        return; 
    } 
    twitter.completionHandler = ^(TWTweetComposeViewControllerResult res)
    { 
        if (res == TWTweetComposeViewControllerResultDone) 
        { 
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Tweet Successful!" message:@"Your tweet was Successful!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
            [alertView show];
            //[self.navigationController popToRootViewControllerAnimated:YES];
        } else if (res == TWTweetComposeViewControllerResultCancelled) 
        {
//            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Oh Dear" message:@"Tweet Failed to send, try again later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
//            [alertView show];
            
        }
        [self dismissModalViewControllerAnimated:YES]; 
        [self.navigationController popToRootViewControllerAnimated:YES];
    };
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
