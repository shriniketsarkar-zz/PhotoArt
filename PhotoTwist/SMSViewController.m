//
//  SMSViewController.m
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 3/4/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import "SMSViewController.h"

@implementation SMSViewController

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
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc]init];
    picker.messageComposeDelegate = self;
    [picker setBody:@"I am using PhotoArt to create amazing Collage with Photo Art. You can try it too."];
    [self presentModalViewController:picker animated:YES];
    
    [super viewDidLoad];
}

//The Message compose view controller delegate method
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
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
